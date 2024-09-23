{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;

      lfs.enable = true;

      extraConfig = {
        init = {defaultBranch = "master";};

        user = {
          name = "crolbar";
          email = "crolbar@crolbar.com";
        };

        url."https://github.com/".insteadOf = ["gh:"];

        http.postBuffer = 157286400;

        core.askPass = "";

        credential = {
          helper = "store";

          "https://github.com/crolbar" = {
            username = "crolbar";
          };
          "https://github.com/voicegrip" = {
            username = "voicegrip";
          };
        };
      };
    };

    git-cliff = {
      enable = true;
      settings = {
        git = {
          filter_unconventional = false;
          commit_parsers = [
            {
              message = ".*";
              group = "Other";
            }
          ];
        };
      };
    };
  };
}
