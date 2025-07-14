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
    ./age.nix
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
    yt-dlp
    license-generator
    gocryptfs
    direnv
    evemu
    openssl
    sqlite
    onefetch
  ];
}
