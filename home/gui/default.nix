{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    floorp
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

    nur.repos.nltch.spotify-adblock
    nur.repos.nltch.ciscoPacketTracer8
  ];
}
