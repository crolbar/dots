{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./git.nix
    ./zsh.nix
    ./starship.nix
    ./tmux.nix
    ./gitui.nix
    ./lazygit.nix
    ./zellij.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
    fd
    htop
    pamixer
    fzf
    zip
    unzip
    tree
    gdu
    jq
    duf
    bottom
    ripgrep
    socat
    ddccontrol
    exiftool
    trash-cli
    pulseaudioFull # for pactl
    cachix
    cyme
    yt-dlp
    license-generator
    #(pkgs.callPackage ../../derivations/binsider.nix {})
  ];
}
