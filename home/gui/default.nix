{pkgs, ...}: {
  imports = [
    ./zathura.nix
    ./eww
    ./spotify.nix
    ./schizofox.nix
    ./obs.nix
    ./term_emulators
    ./zoho.nix
    ./nextcloud.nix
  ];

  home.packages = with pkgs; [
    chromium
    vscodium
    file-roller
    mpv
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
    loupe
    calibre
    xfce.xfce4-dict
    kicad
  ];
}
