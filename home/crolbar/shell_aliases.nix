{
  programs.zsh.shellAliases = {
    ls = "lsd -a --group-directories-first";
    ll = "lsd -la --group-directories-first";
    cdd = "cd ..";

    vim = "nvim";
    vimc = "cd ~/.config/nvim && nvim .";

    vs = "cd ~/.config/hypr && nvim .";

    n = "cd ~/.config/nixos && vim .";
    ns = "nix-shell";

    reb = "sudo nixos-rebuild switch --flake /home/crolbar/.config/nixos#crolbar";
    hreb = "home-manager switch --flake /home/crolbar/.config/nixos#crolbar";

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
  };
}
