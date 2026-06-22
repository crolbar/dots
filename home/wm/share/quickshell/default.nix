{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];

  /*

  - open/close certain windows with cmd
  
  */

  xdg.configFile."quickshell".source = ./shell;
}
