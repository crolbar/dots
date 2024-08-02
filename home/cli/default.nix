{pkgs, ...}: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./yazi.nix
    ./tmux.nix
    ./gitui.nix
    ./zellij.nix
    ./neovim
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
    bottom
    firebase-tools
    syncthing
    xorg.xmodmap
    ripgrep
    socat
    playerctl
    ddccontrol
    exiftool
    trash-cli
  ];
}
