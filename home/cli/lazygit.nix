{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit.overrideAttrs (oldAttrs: rec {
      version = "0.45.0";

      src = pkgs.fetchFromGitHub {
        owner = "jesseduffield";
        repo = "lazygit";
        rev = "v${version}";
        hash = "sha256-hGJDsx0klccbueP7h5HtcYioFLL4gf3W3lbOHIA36FA=";
      };
    });
    settings = {
      gui = {
        scrollPastBottom = false;
        scrollOffMargin = 15;
        nerdFontsVersion = "3";
        switchTabsWithPanelJumpKeys = false;
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

          refresh = "";

          gotoTop = "g";
          gotoBottom = "G";
        };
        stash = {
          popStash = "<enter>";
        };
        commits = {
          viewResetOptions = "R";
          renameCommitWithEditor = "";
        };
        branches = {
          renameBranch = "<c-R>";
        };
      };
    };
  };
}
