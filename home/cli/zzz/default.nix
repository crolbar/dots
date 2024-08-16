{pkgs, ...}: {
  imports = [./dapu.nix];
  home.packages = with pkgs; [
    matm
    tt-rs
    npassm
    lobster
  ];
}