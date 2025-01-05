{inputs', ...}: {
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    package = inputs'.ghostty.packages.default;

    settings = {
      theme = "crolbar";
      background-opacity = 0.8;

      window-decoration = false;

      cursor-style = "block";

      cursor-style-blink = false;

      font-family = "Hack";
      font-style = "Regular";
      font-size = 10;

      confirm-close-surface = false;

      custom-shader = toString ./ghostty_shaders/snow.glsl;

      keybind = [
        "shift+ctrl+c=copy_to_clipboard"
        "shift+ctrl+v=paste_from_clipboard"

        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
      ];
    };

    themes = {
      crolbar = {
        palette = [
          "8=#393939"
          "9=#ee5396"
          "10=#42be65"
          "11=#ffe97b"
          "12=#33b1ff"
          "13=#ff7eb6"
          "14=#3ddbd9"
          "15=#ffffff"

          "0=#000000"
          "1=#ff7eb6"
          "2=#42be65"
          "3=#ffe97b"
          "4=#33b1ff"
          "5=#ff7eb6"
          "6=#3ddbd9"
          "7=#dde1e6"
        ];

        foreground = "ffffff";
        background = "000000";

        cursor-color = "ff7eb6";

        selection-background = "525252";
        selection-foreground = "dde1e6";
      };
    };
  };
}
