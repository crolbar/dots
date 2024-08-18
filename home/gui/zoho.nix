{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../../drvs/zohoMail.nix {})
  ];
}
