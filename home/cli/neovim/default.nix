{
  pkgs,
  nvim_conf,
  ...
}: {
  xdg.configFile.nvim = {
    source = nvim_conf;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ripgrep
      gcc
      fd
    ];
  };
}
