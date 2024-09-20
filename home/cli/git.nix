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

        core.askPass = "";
        credential.helper = "store";
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
