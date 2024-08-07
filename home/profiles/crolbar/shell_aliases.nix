{
  programs.zsh.shellAliases = {
    vimc = "cd ~/Github/dots/home/cli/neovim/nvim && nvim .";

    vs = "cd ~/.config/hypr && nvim .";

    n = "cd ~/Github/dots && vim .";
    ns = "nix-shell";

    reb = "sudo nixos-rebuild switch --flake ~/Github/dots";
    hreb = "home-manager switch --flake ~/Github/dots";
    vreb = "cd ~/Github/dots && nix flake update nvim_conf && hreb && rm -rf ~/.cache/nvim";

    plier = "ssh plier@192.168.1.27";
    crol = "ssh crolbar@192.168.1.12";
    screw = "ssh screw@192.168.1.11";
    kubo = "ssh kubo@crolbar.xyz";
    vm = "ssh crolbar@192.168.122.140";

    mnas = "sudo mount -t nfs 192.168.1.11:/nas /mnt/nas -o rw -o async";
    umnas = "sudo umount /mnt/nas";
    nas = "cd /mnt/nas";

    d = ". ~/scripts/dapu.sh";
    dc = ". ~/scripts/dapu.sh cd";

    tt = "tt-rs";
    t = "tmux";
    z = "zellij";
  };
}
