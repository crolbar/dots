{
  programs.zsh.shellAliases = {
    vimc = "cd ~/.config/nvim && nvim .";

    ns = "nix-shell";

    t = "tmux";

    n = "cd ~/Github/dots && vim .";

    reb = "sudo nixos-rebuild switch --flake ~/Github/dots";
    hreb = "home-manager switch --flake ~/Github/dots";
  };
}
