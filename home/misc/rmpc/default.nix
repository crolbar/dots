{
  pkgs,
  config,
  ...
}: let
  musicDir = "${config.home.homeDirectory}/Music";
in {
  services = {
    mpd-discord-rpc = {
      enable = true;
      settings = {
        id = 1283875986626187304;
      };
    };
    mpd = {
      enable = true;
      musicDirectory = musicDir;
      playlistDirectory = "${musicDir}/playlists";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
        audio_output {
          type "fifo"
          name "pipe"
          path "/tmp/mpd.fifo"
        }
        replaygain "track"
        replaygain_limit "no"
      '';
    };
  };

  home.packages = [
    #(pkgs.callPackage ../../../drvs/rmpc.nix {})
    pkgs.rmpc
  ];

  xdg.configFile."rmpc/config.ron".source = ./config.ron;
  xdg.configFile."rmpc/themes/main.ron".source = ./theme.ron;

  xdg.configFile."rmpc/notify.sh".source = pkgs.writers.writeBash "notify.sh" ''
    TMP_DIR="/tmp/rmpc"
    mkdir -p "$TMP_DIR"
    ALBUM_ART_PATH="$TMP_DIR/notification_cover"
    DEFAULT_ALBUM_ART_PATH="$TMP_DIR/default_album_art.jpg"

    if ! rmpc albumart --output "$ALBUM_ART_PATH"; then
        ALBUM_ART_PATH="''${DEFAULT_ALBUM_ART_PATH}"
    fi

    dunstctl close
    dunstify -i "''${ALBUM_ART_PATH}" "$TITLE" "$ARTIST"
  '';
}
