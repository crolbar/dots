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
      rev = "2c476b442ccfda9935e472b26d9cd60d45726560";
      sha256 = "sha256-Y+dcVX2zXkYaHvsS+SuhqqCnwwm188dj0VJf7BYxzHs=";
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

      popwin

      evil
      evil-collection
      evil-surround
      evil-goggles

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
