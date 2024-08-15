{pkgs, ...}: {
  imports = [
    ./zathura.nix
    ./eww
    ./spotify.nix
    ./schizofox.nix
    ./obs.nix
    ./term_emulators
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
    pwvucontrol # go to audio
    celluloid
    loupe
  ];
}
