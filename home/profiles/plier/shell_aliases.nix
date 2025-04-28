{
  pkgs,
  lib,
  ...
}: let
  zsh = "${lib.getExe pkgs.zsh}";
  virsh = lib.getExe' pkgs.libvirt "virsh";
  virt-manager = lib.getExe pkgs.virt-manager;
in {
  home.packages = with pkgs; [dig nfs-utils];

  programs.zsh.shellAliases = {
    vimc = "cd ~/Github/dots/home/editors/neovim/nvim && nvim .";

    n = "cd ~/Github/dots && vim .";

    ns = "nix-shell --command \"bash -c \\\"SHELL=${zsh} && ${zsh}\\\"\"";
    nd = "nix develop --command bash -c \"SHELL=${zsh} && \"${zsh}\"\"";

    reb = "sudo nixos-rebuild switch --flake ~/Github/dots";
    hreb = "home-manager switch --flake ~/Github/dots";
    vreb = "cd ~/Github/dots && nix flake update nvim_conf && hreb && rm -rf ~/.cache/nvim";

    crol = "ssh crolbar@192.168.1.12";
    screw = "ssh screw@screw";
    kubo = "ssh kubo@crolbar.xyz";

    v = "sudo ${virsh}";
    vm = "${virt-manager} --connect qemu:///system --show-domain-console";

    mdec = "gocryptfs /mnt/nas/enc ~/dec";
    umdec = "fusermount -u ~/dec";

    mnas = "sudo mount.nfs screw:/nas /mnt/nas -o rw";
    umnas = "sudo umount /mnt/nas";
    nas = "cd /mnt/nas";

    d = ". ~/scripts/dapu.sh";
    dc = ". ~/scripts/dapu.sh cd";

    tt = "tt-rs";
    t = "tmux";
    z = "zellij";

    pubip = "dig @resolver4.opendns.com myip.opendns.com +short";
    pubip6 = "dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";

    fmon = "systemctl start --user kanshi";
  };

  programs.zsh.initExtra = ''
    it() {
        nix flake init -t github:crolbar/dots#$1
    }
  '';
}
