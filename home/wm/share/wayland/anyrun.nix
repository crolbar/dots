{
  anyrun,
  pkgs,
  ...
}: {
  imports = [anyrun.homeManagerModules.default];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [anyrun.packages.${pkgs.system}.applications];

      x = {fraction = 0.922;};
      width = {absolute = 400;};
      hidePluginInfo = true;
      closeOnClick = false;
    };

    extraCss = ''
      #window {
          background-color: rgba(0, 0, 0, 0);
          font-size: 16px;
      }
      list#plugin {
          background-color: rgba(0, 0, 0, 0);
      }
      entry {
          background-color: rgba(0, 0, 0, 0.749);
          border: none;
          border-radius: 0;
      }
      list#main {
          background-color: rgba(0, 0, 0, 0.749);
      }
    '';

    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        max_entries: 19,
        terminal: Some("alacritty"),
      )
    '';
  };
}
