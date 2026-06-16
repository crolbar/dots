{
  pkgs,
  lib,
  ...
}: let
  lswt = lib.getExe pkgs.lswt;
  eww = lib.getExe pkgs.eww;
  jq = lib.getExe pkgs.jq;

  s = pkgs.writers.writeBash "brok.sh" ''
    closerPID=""

    runAfter() {
        ( sleep "$1"; shift; "$@" ) &
    }


    brokctl sub | while IFS= read -r line; do
      [[ -z "$line" ]] && continue

      players=$(${jq} -c -r ".players" <<< "$line")

      # replace file://
      new_players=$(${jq} -c -r '
        map(
          if (.artUri | startswith("file://")) then
              # remove file:// prefix
              .artUri = (.artUri | sub("^file://"; ""))
          end
        )
      ' <<< "$players")

      # fetch https:// images and replace with file paths
      mapfile -t uris < <(${jq} -r '.[].artUri' <<< "$new_players")
      for uri in "''${uris[@]}"; do
          if [[ -z "$uri" ]]; then
            continue
          fi


          if [[ "$uri" == /* ]]; then
              continue
          fi

          filename="''${uri##*/}"
          out="/tmp/brok-$filename"

          if [[ ! -f "$out" ]]; then
            curl -s --output "$out" "$uri"
          fi


          # Replace this specific URL with the downloaded file path
          new_players=$(${jq} -c --arg old "$uri" --arg new "$out" '
              map(if .artUri == $old then .artUri = $new else . end)
          ' <<< "$new_players")
      done

      # using this instead of a listener (deflistener does not run when window is closed, this updates it)
      ${eww} -c ~/.config/eww update brok="$new_players"

      #
      # open/closer functionality
      #

      up=$(${jq} -c -r '."brokctl-update"' <<< "$line")
      if [[ ''${#up} -le 0 ]]; then
        # TODO: add x11 support & other compositors
        focusedWindow=""
        if pgrep -x niri > /dev/null; then
          focusedWindow=$(niri msg -j focused-window | jq -c -r '.app_id')
        else
          focusedWindow=$(${lswt} -c 'aA' | grep true | cut -d "," -f 1)
        fi
        focusedPlayer=$(${jq} -c -r '.[0].name' <<< "$new_players")

        focusedWindow=''${focusedWindow,,}
        focusedPlayer=''${focusedPlayer,,}

        if [[ "$focusedPlayer" == *"$focusedWindow"* || "$focusedWindow" == *"$focusedPlayer"* ]]; then
          continue
        fi
      fi

      if [[ $SECONDS -lt 1 ]]; then
        continue
      fi


      isNotOpen=$(${eww} -c ~/.config/eww active-windows | grep brok >/dev/null 2>&1; echo $?)

      # brok window is already open
      if [[ $isNotOpen -eq 0 ]]; then
        # prevent from closing
        if [[ -n $closerPID ]]; then
          kill "$closerPID" 2>/dev/null
          closerPID=""
        fi

        # IF THE FILE IS NOT MISSING, DEYLAY THE CLOSING
        #
        # this file would be missing only if we have remoed it
        # currently removing it from eww for this exact pourposue here
        if [[ -f /tmp/brok-closer-pid ]]; then
          # delay closing
          runAfter 2 ${eww} -c ~/.config/eww close brok
          closerPID=$!
          echo "$closerPID" > /tmp/brok-closer-pid
        fi

        continue
      fi


      ${eww} -c ~/.config/eww open brok

      if [[ -n $closerPID ]]; then
        closerPID=""
      fi
      runAfter 2 ${eww} -c ~/.config/eww close brok
      closerPID=$!
      echo "$closerPID" > /tmp/brok-closer-pid


      SECONDS=0
    done
  '';
in {
  systemd.user.services.brok-eww = {
    Unit = {
      Description = "brok-eww";
      After = ["graphical-session.target" "brokd.service"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${s}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
