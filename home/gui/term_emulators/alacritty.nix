{
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;

      window = {
        opacity = 0.8;
        decorations = "none";
        dynamic_title = true;
      };

      colors = {
        bright = {
          black = "#393939";
          magenta = "#ff7eb6";
          green = "#42be65";
          yellow = "#ffe97b";
          blue = "#33b1ff";
          red = "#ee5396";
          cyan = "#3ddbd9";
          white = "#ffffff";
        };

        normal = {
          black = "#000000";
          magenta = "#ff7eb6";
          green = "#42be65";
          yellow = "#ffe97b";
          blue = "#33b1ff";
          red = "#ee5396";
          cyan = "#3ddbd9";
          white = "#dde1e6";
        };
        primary = {
          background = "#000000";
          foreground = "#ffffff";
        };

        selection = {
          background = "#525252";
          text = "CellForeground";
        };

        cursor = {
          text = "#000000";
          cursor = "#ff7eb6";
        };
      };

      cursor = {
        blink_interval = 550;
        unfocused_hollow = false;
        style = {
          blinking = "On";
          shape = "Block";
        };
      };

      selection = {
        save_to_clipboard = false;
      };

      font = {
        size = 10;
        bold.family = "Hack";
        bold_italic.family = "Hack";
        italic.family = "Hack";
        normal.family = "Hack";
      };
    };
  };
}
