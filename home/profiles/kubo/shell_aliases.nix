{
  programs.zsh.shellAliases = {
    vimc = "cd ~/.config/nvim && nvim .";

    ns = "nix-shell";

    mnas = "sudo mount -t nfs 192.168.1.11:/nas /mnt/nas -o rw -o async";
    umnas = "sudo umount /mnt/nas";
    nas = "cd /mnt/nas";

    t = "tmux";

    n = "cd ~/Github/dots && vim .";

    reb = "sudo nixos-rebuild switch --flake ~/Github/dots";
    hreb = "home-manager switch --flake ~/Github/dots";
  };
}
