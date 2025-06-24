{
  pkgs,
  lib,
  ...
}: let
  epkgs = pkgs.emacsPackages;

  corfu = epkgs.corfu.overrideAttrs (oldAttrs: {
    version = "1.7";
    src = pkgs.fetchFromGitHub {
      owner = "minad";
      repo = "corfu";
      rev = "c302b0526ad9d0c99d1d0639df63f6ca65accfc3";
      sha256 = "sha256-bdlL4MkcXmP1019RYB+58QJ3Ak5tPslunSpE3gta1zw=";
    };
  });

  plugins = with epkgs;
    [
      # modes
      nix-mode
      web-mode
      go-mode
      lua-mode
      php-mode
      rust-mode
      groovy-mode
      yuck-mode
      yaml-mode
      typst-ts-mode

      # non programming
      ron-mode
      markdown-mode

      # lsp
      eglot
      eldoc-box

      # cmp
      corfu
      yasnippet

      # fmt
      format-all

      # git
      magit
      diff-hl
      dired-gitignore

      undo-tree

      fzf
      rg
      smex

      popwin

      evil
      evil-collection
      evil-surround
      evil-goggles

      # brrr
      avy

      # misc
      (pkgs.ispell)
      elcord
      org-fragtog
      nerd-icons
      nerd-icons-dired
      vterm
      direnv
      gcmh
    ]
    ++ [
      epkgs."ido-completing-read+"
    ];
in {
  home.packages =
    plugins
    ++ [
      pkgs.tetex
      pkgs.perl # magit needs
    ];

  home.file.".emacs.d/pkgs.el".text = let
    req = p: "(require '" + (lib.getName p) + ")";
  in
    builtins.concatStringsSep "\n" (map req plugins);
}
