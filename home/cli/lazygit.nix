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
          activeBorderColor = ["#999999" "bold"];
          inactiveBorderColor = ["#393939"];
          optionsTextColor = ["#797979"];
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
