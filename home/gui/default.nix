{pkgs, ...}: {
  imports = [
    ./zathura.nix
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
    qemu
    obsidian
    networkmanagerapplet
    vesktop
    pwvucontrol
    celluloid
    ristretto
    calibre
    xfce4-dict
    # kicad
    blueman
    eww
  ];
}
