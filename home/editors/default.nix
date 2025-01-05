{username, ...}: let
  imps =
    if builtins.elem username ["crolbar" "plier"]
    then [./neovim ./emacs]
    else [./neovim];
in {
  imports = imps;
}
