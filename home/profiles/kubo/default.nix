{...}: {
  imports = [
    ./shell_aliases.nix
  ];

  home.stateVersion = "23.11";
  home.username = "kubo";
  home.homeDirectory = "/home/kubo";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
