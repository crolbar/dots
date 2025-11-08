{pkgs, ...}: {
  imports = [
    ./zathura.nix
    ./eww
    ./spotify.nix
    ./browsers
    ./obs.nix
    ./term_emulators
    ./zoho.nix
    ./nextcloud.nix
    ./mpv.nix
  ];

  home.packages = with pkgs; [
    chromium
    vscodium
    file-roller
    pavucontrol
    discord
    keepassxc
    gimp
    libreoffice
    qbittorrent
    gnome-disk-utility
    polkit_gnome
    qemu # maybe make virt category ?
    arduino-ide
    obsidian
    networkmanagerapplet
    vesktop
    pwvucontrol # go to audio
    celluloid
    xfce.ristretto
    calibre
    xfce.xfce4-dict
    kicad
    blueman
  ];
}
