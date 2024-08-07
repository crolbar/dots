{pkgs, ...}: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./starship.nix
    ./yazi.nix
    ./tmux.nix
    ./gitui.nix
    ./zellij.nix
    ./neovim
  ];

  home.packages = with pkgs; [
    ffmpeg
    fd
    btop
    htop
    pamixer
    tldr
    fzf
    zip
    unzip
    tree
    xorg.xev
    ncdu
    skim
    jq
    bottom
    xorg.xmodmap
    ripgrep
    socat
    ddccontrol
    exiftool
    trash-cli

    syncthing
  ];
}
