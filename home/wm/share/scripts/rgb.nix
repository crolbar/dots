{pkgs, ...}: let
  colors = [
    [50 0 0]
    [0 50 0]
    [0 0 50]
    [0 50 50]
  ];

  # Just because I have brain damage.
  addColors =
    "colors+=("
    + (builtins.concatStringsSep ")\ncolors+=(" (
      map
      (c: ''"'' + (builtins.concatStringsSep " " (map (_c: toString _c) c)) + ''"'')
      colors
    ))
    + ")";
in {
  home.file."scripts/rgb.sh".source = pkgs.writers.writeBash "rgb.sh" ''
    case $1 in
        s)
            if pgrep -f "KeyboardVisualizer" > /dev/null; then
                pkill .KeyboardVisual
            else
                cd && KeyboardVisualizer
            fi
            exit;;
    esac

    colorFile="$HOME/scripts/.rgb_color"

    colors=()
    ${addColors}

    colorIdx=0

    if [ -f "$colorFile" ]; then
        colorIdx=$(cat "$colorFile")
        ((colorIdx = ((colorIdx + 1) % ''${#colors[@]})))
    fi
    echo $colorIdx > "$colorFile"

    vbz --set-color ''${colors["$colorIdx"]}
  '';
}
