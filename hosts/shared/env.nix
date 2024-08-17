{pkgs, ...}: {
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    homeBinInPath = true;

    defaultPackages = with pkgs; [
      home-manager # for some reason when using hm module uninstalls hm even with `programs.home-manager.enable = true;`
      neovim
      git
      lsd
    ];

    shellAliases = {
      ls = "lsd -a --group-directories-first";
      ll = "lsd -la --group-directories-first";
      cdd = "cd .."; # I don't even know why..
      vim = "nvim";
      ssc = "sudo systemctl";
      scu = "systemctl --user";
    };
  };
}
