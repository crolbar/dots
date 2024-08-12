{username, ...}: {
  imports = [
    ./shell_aliases.nix
  ];

  home.stateVersion = "23.11";
  home.username = username;
  home.homeDirectory = "/home/${username}";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
