let
  bg = "#161616";
  fg = "#CCCCCC";
in {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      statusbar-bg = bg;
      statusbar-fg = fg;

      notification-bg = bg;
      notification-fg = fg;

      default-bg = bg;
      default-fg = fg;

      recolor-lightcolor = bg;
      recolor-darkcolor = fg;
      recolor = true;
    };
    mappings = {
      f = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
    };
  };
}
