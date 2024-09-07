{pkgs, ...} @ args: {
  xdg.configFile."river/eww/scripts/ristate.sh".source = pkgs.writers.writeBash "ristate.sh" ''
    up() {
        echo "$l" | jq '
          .focused_tags as $focused_tags |
          .view_tags as $view_tags |
          .view_tags |=
            with_entries(
              .key as $key |
              .value |= (
                ($view_tags[$key] + ($focused_tags[$key] | map(tonumber? // .))) | unique | sort
              )
            )
        ' -c
    }

    ristate -u -vt -t -f | while read -r l; do up "$l"; done
  '';
}
