{pkgs, ...}: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./yazi.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    vim
    ffmpeg
    git
    lsd
    fd
    btop
    htop
    neofetch
    neovim
    brightnessctl
    light
    pamixer
    tldr
    fzf
    zip
    alacritty
    xclip
    unzip
    tree
    xorg.xev
    ncdu
    tmux
    skim
    jq
    nfs-utils
    inetutils
    bottom
    firebase-tools
    syncthing
    xorg.xmodmap
    dapu
    matm
    tt-rs
    ripgrep
    socat
    playerctl
    gitui
    ddccontrol
    exiftool
    lobster
    npassm
    trash-cli

    # make dev cateogry
    nixd
    nil
    alejandra

    gcc
  ];
}
