{pkgs, ...}: {
  environment = {
    variables = {
      EDITOR = "nvim";
      XDG_UTILS_DEFAULT_BROWSER = "zen-twilight";
      XDG_UTILS_DEFAULT_TERMINAL = "foot";
      XDG_UTILS_DEFAULT_FILE_MANAGER = "yazi";
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXOS_OZONE_WL = "1";
    };

    homeBinInPath = true;

    defaultPackages = with pkgs; [
      home-manager # for some reason when using hm module uninstalls hm even with `programs.home-manager.enable = true;`
      vim
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
      nix-clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
  };
}
