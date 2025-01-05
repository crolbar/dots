{pkgs, ...}: let
  emacs = pkgs.emacs-pgtk;
in {
  services.emacs = {
    enable = true;
    package = emacs;
  };

  programs.emacs = {
    enable = true;
    package = emacs;
  };
}
