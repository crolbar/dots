{pkgs, ...}: {
  imports = [
    ./steam.nix
  ];

  environment.defaultPackages = [
    pkgs.oversteer
  ];
}
