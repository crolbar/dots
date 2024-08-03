{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
    mappings = {
      f = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
    };
  };
}
