{
  pkgs,
  celestia,
  ...
}: {
  imports = [
    celestia.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = false;
    settings = {
      border = {
        thickness = 0;
        rounding = 0;
        smoothing = 0;
      };
    };
  };

  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];

  # xdg.configFile."quickshell".source = ./shell;
}
