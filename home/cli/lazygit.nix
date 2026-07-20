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
          activeBorderColor = ["#ebdbb2" "bold"];
          inactiveBorderColor = ["#928374"];
          optionsTextColor = ["#fabd2f"];
          selectedLineBgColor = ["#5a524c"];
          cherryPickedCommitBgColor = ["#5a524c"];
          cherryPickedCommitFgColor = ["#fe8019" "bold" "reverse"];
          unstagedChangesColor = ["#cc241d"];
          defaultFgColor = ["#ebdbb2"];
          searchingActiveBorderColor = ["#cc241d"];
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
