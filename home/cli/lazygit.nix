{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        scrollPastBottom = false;
        nerdFontsVersion = "3";
        splitDiff = "always";
      };
      git = {
        autoFetch = false;
      };
    };
  };
}
