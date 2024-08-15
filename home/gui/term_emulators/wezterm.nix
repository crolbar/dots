{inputs', ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;
    #package = inputs'.wezterm.packages.default;

    extraConfig = ''
      local wezterm = require 'wezterm';
      return {
          check_for_updates = false,

          exit_behavior = "CloseOnCleanExit",
          audible_bell = "Disabled",
          enable_tab_bar = false,


          window_background_opacity = 0.8,
          window_padding = { left = 0, right = 0, top = 0, bottom = 0, },
          adjust_window_size_when_changing_font_size = false,
          warn_about_missing_glyphs =  false,



          allow_square_glyphs_to_overflow_width = "Always",
          font_size = 10.0,
          font = wezterm.font 'Hack',

          front_end = "OpenGL",
          webgpu_power_preference = "HighPerformance",
          enable_wayland = false, -- if not on release enable this else disable

          colors = {
              foreground = "#ffffff",
              background = "#000000",

              ansi = {
                  "#000000", -- black
                  "#cc0403", -- red
                  "#19cb00", -- green
                  "#cecb00", -- yellow
                  "#0d73cc", -- blue
                  "#cb1ed1", -- magenta
                  "#0dcdcd", -- cyan
                  "#dddddd", -- white
              },

              brights = {
                  "#767676", -- black
                  "#cc0403", -- red
                  "#23fd00", -- green
                  "#fffd00", -- yellow
                  "#1a8fff", -- blue
                  "#fd28ff", -- magenta
                  "#14ffff", -- cyan
                  "#ffffff", -- white
              },
          },
      }
    '';
  };
}
