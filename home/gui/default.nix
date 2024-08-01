{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    floorp
    brave
    vscodium
    file-roller
    mpv
    lxappearance
    pavucontrol
    discord
    keepassxc
    gimp
    feh
    mate.eom
    flameshot
    libreoffice
    zathura
    qbittorrent
    gnome-disk-utility
    polkit_gnome
    qemu # maybe make virt category ?
    arduino-ide
    obsidian
    emacs
    networkmanagerapplet
    vesktop
    nwg-look
    mangohud
    pwvucontrol
    xclip
    xcolor
    hyprpicker
    ueberzugpp
    wl-clipboard
    grim
    slurp
    capitaine-cursors

    nur.repos.nltch.spotify-adblock
    nur.repos.nltch.ciscoPacketTracer8
  ];
}
