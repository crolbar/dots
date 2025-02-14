{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./settings.nix
    ./kanshi.nix
    ./eww

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = with pkgs; [
    polkit_gnome
    wideriver # layout generator
    lswt # shows title & app-id of views
  ];

  xdg.configFile."gtk-3.0/gtk.css".text = ''
    headerbar.titlebar.default-decoration {
      background: transparent;
      opacity: 0;
      margin: 0 0 -35px 0;
    }
    window.csd,
    window.csd decoration {
      box-shadow: none;
    }
  '';

  wayland.windowManager.river = {
    enable = true;

    extraSessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
