{pkgs, ...}:
{
  home.packages = with pkgs; [
    dapu
    matm
    tt-rs
    npassm

    lobster
  ];
}

