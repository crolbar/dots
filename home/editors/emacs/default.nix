{pkgs, ...}: let
  # emacs-unstable-pgtk(wayland native), emacs-unstable (latest tag)
  # emacs-git-pgtk (latest commit in master)
  emacs = pkgs.emacs-unstable;
in {
  imports = [./epkgs.nix];
  home.file.".emacs.d/init.el".source = ./init.el;
  home.file.".emacs.d/crol.el".source = ./crol.el;

  services.emacs = {
    enable = true;
    package = emacs;
    startWithUserSession = "graphical";
  };

  programs.emacs = {
    enable = true;
    package = emacs;
  };
}
