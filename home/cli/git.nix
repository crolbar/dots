{...}: {
  programs.git = {
    enable = true;

    extraConfig = {
      init = {defaultBranch = "master";};
      user = {
        name = "crolbar";
        email = "crolbar@crolbar.com";
      };
      url."https://github.com/".insteadOf = ["gh:"];
      credential.helper = "store";
    };
  };
}
