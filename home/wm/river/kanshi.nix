{
  # alt to `-enable-features=UseOzonePlatform --ozone-platform=wayland`
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  # `https://home-manager-options.extranix.com/?query=kanshi`
  services.kanshi = {
    enable = true;
    systemdTarget = "river-session.target";
    settings = [
      {
        output = {
          criteria = "eDP-1";
          scale = 2.0;
        };
      }

      {
        profile = rec {
          name = "single";
          exec = "dunstify kanshi \"Switched to ${name}\"";
          outputs = [
            {
              criteria = "eDP-1";
            }
          ];
        };
      }

      {
        profile = rec {
          name = "test";
          exec = "dunstify kanshi \"Switched to ${name}\"";
          outputs = [
            {
              criteria = "eDP-1";
            }
            {
              criteria = "HDMI-A-1";
              transform = "270";
            }
          ];
        };
      }
    ];
  };
}
