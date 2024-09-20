{pkgs, ...}: {
  home.packages = [
    (pkgs.callPackage ../../derivations/zohoMail.nix {})
  ];
}
