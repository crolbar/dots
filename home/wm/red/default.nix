{pkgs, ...}: {
  home.packages = [
    (pkgs.writers.writeBashBin "rd" ''
      uwsm start red
    '')
  ];
}
