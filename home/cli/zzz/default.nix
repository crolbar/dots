{pkgs, ...}: {
  imports = [./dapu.nix];
  home.packages = with pkgs; [
    matm
    tt-rs
    npassm
    gazi
    gql
    salg
    go29
    auvi
    vbz
    stray
  ];
}
