{
  pkgs,
  nvim_conf,
  ...
}: {
  xdg.configFile.nvim = {
    source = nvim_conf;
    recursive = true;
  };

  home.packages = with pkgs; [
    neovim.unwrapped
    ripgrep
    gcc
    fd
  ];
}
