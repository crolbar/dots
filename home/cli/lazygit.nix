{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        scrollPastBottom = false;
        scrollOffMargin = 15;
        nerdFontsVersion = "3";
        splitDiff = "always";
        authorColors = {
          "*" = "white";
        };
        theme = {
          selectedLineBgColor = ["#393939"];
        };
      };
      git = {
        autoFetch = false;
      };
      keybinding = {
        universal = {
          prevScreenMode = "-";
          goInto = "l";
          prevBlock-alt = "";
        };
      };
    };
  };
}
