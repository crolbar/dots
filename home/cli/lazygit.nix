{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        scrollPastBottom = false;
        scrollOffMargin = 15;
        nerdFontsVersion = "3";
        splitDiff = "always";
      };
      git = {
        autoFetch = false;
      };
      keybinding = {
        universal = {
          prevScreenMode = "-";
        };
      };
    };
  };
}
