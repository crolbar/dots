{
  pkgs,
  nvim_conf,
  inputs',
  ...
}: {
  xdg.configFile.nvim = {
    source = nvim_conf;
    recursive = true;
  };

  xdg.configFile."nvim/after/queries/blade/highlights.scm".text = ''
    (directive) @function
    (directive_start) @function
    (directive_end) @function
    (comment) @comment
    ((parameter) @include (#set! "priority" 110))
    ((php_only) @include (#set! "priority" 110))
    ((bracket_start) @function (#set! "priority" 120))
    ((bracket_end) @function (#set! "priority" 120))
    (keyword) @function
  '';

  xdg.configFile."nvim/after/queries/blade/injections.scm".text = ''
    ((text) @injection.content
        (#not-has-ancestor? @injection.content "envoy")
        (#set! injection.combined)
        (#set! injection.language php))
  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs'.neovim-overlay.packages.default;

    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
  };

  home.packages = with pkgs; [
    ripgrep
    gcc
    fd
  ];
}
