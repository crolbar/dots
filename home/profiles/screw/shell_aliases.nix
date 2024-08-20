{
  pkgs,
  lib,
  ...
}: let
  zsh = "${lib.getExe pkgs.zsh}";
in {
  programs.zsh.shellAliases = {
    vimc = "cd ~/Github/dots/home/cli/neovim/nvim && nvim .";

    ns = "nix-shell --command \"bash -c \\\"SHELL=${zsh} && ${zsh}\\\"\"";
    nd = "nix develop --command bash -c \"SHELL=${zsh} && \"${zsh}\"\"";

    t = "tmux";

    n = "cd ~/Github/dots && vim .";

    reb = "sudo nixos-rebuild switch --flake ~/Github/dots";
    hreb = "home-manager switch --flake ~/Github/dots";
  };
}
