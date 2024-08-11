{...}: {
  imports = [
    ./shell_aliases.nix
  ];

  home.stateVersion = "23.11";
  home.username = "screw";
  home.homeDirectory = "/home/screw";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
