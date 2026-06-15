{pkgs, ...}: {
  imports = [
    ./steam.nix
  ];

  environment.defaultPackages = with pkgs; [
    oversteer
    lutris
  ];
}
