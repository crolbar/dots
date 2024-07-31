{pkgs, ...}: {
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    fd
    btop
    htop
    neofetch
    vim
    git
    lsd
    neovim
    zip
    unzip
    tree
    tmux
    skim
    jq
    nfs-utils
    ripgrep
    gitui

    nixd
    nil
    alejandra

    gcc
  ];
}
