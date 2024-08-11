{...}: {
  imports = [
    ./shell_aliases.nix
  ];

  home.stateVersion = "23.11";
  home.username = "crolbar";
  home.homeDirectory = "/home/crolbar";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
