{
  inputs',
  clib,
  nonNixOS,
  config,
  ...
}: {
  home.packages = [inputs'.microfetch.packages.default];
  programs.zsh = let
    hostConf = clib.ifA nonNixOS (import ../../hosts/shared/cli/zsh.nix).programs.zsh;
  in {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      path = "$HOME/.config/zsh/zsh_history";
      ignorePatterns = ["t"];
    };

    autocd = true;

    initContent =
      (clib.ifS nonNixOS hostConf.shellInit)
      + "microfetch";

    syntaxHighlighting = clib.ifA nonNixOS hostConf.syntaxHighlighting;
  };
}
