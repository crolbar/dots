{
  pkgs,
  lib,
  ...
}: let
  zsh = "${lib.getExe pkgs.zsh}";
in {
  home.packages = with pkgs; [dig nfs-utils lsd];

  programs.zsh.shellAliases = {
    ls = "lsd -a --group-directories-first";
    ll = "lsd -la --group-directories-first";

    vim = "nvim";
    ssc = "sudo systemctl";
    scu = "systemctl --user";

    vimc = "cd ~/Github/dots/home/editors/neovim/nvim && nvim .";

    n = "cd ~/Github/dots && vim .";

    ns = "nix-shell --command \"bash -c \\\"SHELL=${zsh} && ${zsh}\\\"\"";
    nd = "nix develop --command bash -c \"SHELL=${zsh} && \"${zsh}\"\"";

    hreb = "home-manager switch --flake ~/Github/dots";
    vreb = "cd ~/Github/dots && nix flake update nvim_conf && hreb && rm -rf ~/.cache/nvim";

    screw = "ssh screw@screw.rs";
    kubo = "ssh kubo@crolbar.xyz";

    mdec = "gocryptfs /mnt/nas/enc ~/dec";
    umdec = "fusermount -u ~/dec";

    mnas = "sudo mount.nfs screw.rs:/nas /mnt/nas -o rw";
    umnas = "sudo umount /mnt/nas";
    nas = "cd /mnt/nas";

    d = ". ~/scripts/dapu.sh";
    dc = ". ~/scripts/dapu.sh cd";

    tt = "tt-rs";
    t = "tmux";
    z = "zellij";

    pubip = "dig @resolver4.opendns.com myip.opendns.com +short";
    pubip6 = "dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
  };
}
