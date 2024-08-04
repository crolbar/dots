{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./zathura.nix
    ./eww
    ./spotify.nix
    ./schizofox.nix
  ];

  home.packages = with pkgs; [
    chromium
    brave
    vscodium
    file-roller
    mpv
    pavucontrol
    discord
    keepassxc
    gimp
    feh
    mate.eom
    libreoffice
    qbittorrent
    gnome-disk-utility
    polkit_gnome
    qemu # maybe make virt category ?
    arduino-ide
    obsidian
    emacs
    networkmanagerapplet
    vesktop
    mangohud
    pwvucontrol
    capitaine-cursors
  ];
}
