{pkgs, ...}: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./starship.nix
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
    gdu
    skim
    jq
    duf
    bottom
    xorg.xmodmap
    ripgrep
    socat
    ddccontrol
    exiftool
    trash-cli
    pulseaudioFull # for pactl
    cachix
    #(pkgs.callPackage ../../drvs/binsider.nix {})
  ];
}
