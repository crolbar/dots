{
  inputs',
  pkgs,
  ...
}: let
  package =
    if builtins.match "x86_64-linux" pkgs.system != null
    then inputs'.zellij.packages.default
    else pkgs.zellij;
in {
  programs.zellij = {
    enable = false;
    inherit package;
  };
}
