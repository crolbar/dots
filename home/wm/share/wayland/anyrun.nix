{inputs', ...}: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [inputs'.anyrun.packages.applications];

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

      list#main,
      entry,
      list#plugin {
          background-color: #161616;
      }

      entry {
          border: none;
          border-radius: 0;
      }
      #match:selected {
          background: #303030;
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
