{pkgs, ...}: {
  imports = [./binds.nix];

  home.packages = [
    (pkgs.writers.writeBashBin "rd" ''
      uwsm start red
    '')
  ];
}
