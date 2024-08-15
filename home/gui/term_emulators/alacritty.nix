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
          black = "#767676";
          blue = "#1a8fff";
          cyan = "#14ffff";
          green = "#23fd00";
          magenta = "#fd28ff";
          red = "#cc0403";
          white = "#ffffff";
          yellow = "#fffd00";
        };

        normal = {
          black = "#000000";
          blue = "#0d73cc";
          cyan = "#0dcdcd";
          green = "#19cb00";
          magenta = "#cb1ed1";
          red = "#cc0403";
          white = "#dddddd";
          yellow = "#cecb00";
        };
        primary = {
          background = "#000000";
          foreground = "#ffffff";
        };

        selection = {
          background = "#252525";
          text = "CellForeground";
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
