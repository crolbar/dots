{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./settings.nix
    ./eww
    ./scripts

    ../share/scripts
    ../share/wayland
    ../share/dunst.nix
    ../share/wall
  ];

  home.packages = [
    pkgs.polkit_gnome
    (pkgs.writers.writeBashBin "hypr" ''
      systemctl --user start hyprland-uwsm
    '')
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "hyprlang";
    # portalPackage = null;
  };

  systemd.user.services.hyprland-uwsm = {
    Service = {
      ExecStart = "${pkgs.uwsm}/bin/uwsm start hyprland.desktop";
      Type = "simple";
      Restart = "no";
      KillMode = "process";
    };
  };
}
