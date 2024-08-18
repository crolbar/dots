{pkgs, ...}: {
  imports = [
    ./zathura.nix
    ./eww
    ./spotify.nix
    ./schizofox.nix
    ./obs.nix
    ./term_emulators
    ./zoho.nix
  ];

  home.packages = with pkgs; [
    chromium
    brave # unused maybe remove ?
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
