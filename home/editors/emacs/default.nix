{pkgs, ...}: let
  emacs = pkgs.emacs-pgtk;
  epkgs = pkgs.emacsPackages;

  corfu = epkgs.corfu.overrideAttrs (oldAttrs: {
    version = "1";
    src = pkgs.fetchFromGitHub {
      owner = "minad";
      repo = "corfu";
      rev = "ec846c6aa373931508cc078b49a3a8ba8265c453";
      sha256 = "sha256-UNykfsL3J+LX6AJmKeWaPZx5zUru3nNO/zSwPdSI830=";
    };
  });
in {
  home.packages = with epkgs;
    [
      # modes
      nix-mode
      web-mode
      go-mode
      lua-mode
      php-mode
      rust-mode
      groovy-mode

      # non programming
      ron-mode
      markdown-mode

      # lsp
      eglot

      # cmp
      corfu
      yasnippet

      # fmt
      clang-format
      format-all

      # git
      magit
      diff-hl
      dired-gitignore

      undo-tree

      fzf
      rg
      smex

      harpoon
      popwin

      evil
      evil-collection
      evil-surround
      evil-goggles

      # misc
      (pkgs.ispell)
      elcord
    ]
    ++ [
      epkgs."ido-completing-read+"
    ];

  home.file.".emacs.d/init.el".source = ./init.el;

  services.emacs = {
    enable = true;
    package = emacs;
  };

  programs.emacs = {
    enable = true;
    package = emacs;
  };
}
