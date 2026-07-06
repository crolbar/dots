{
  pkgs,
  lib,
  config,
  inputs',
  username,
  ...
}: {
  imports = [
    ./binds.nix
    ./eww

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
    ../share/scripts
    ../share/quickshell
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    alsa-utils
    (pkgs.callPackage ../../../derivations/shmooz.nix {})
    (pkgs.writers.writeBashBin "ni" ''
      uwsm start niri
    '')
  ];

  xdg.configFile = {
    "niri/config.kdl" = {
      source = ./config.kdl;
      force = true;
    };

    "niri/autostart.kdl".text = let
      xwayland-satellite = lib.getExe pkgs.xwayland-satellite;
      dunst = lib.getExe pkgs.dunst;
      wallI = "${config.home.file."scripts/wall.sh".source} i";
      nm-applet = lib.getExe' pkgs.networkmanagerapplet "nm-applet";
      awww-daemon = lib.getExe' pkgs.awww "awww-daemon";
    in
      ''
        spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

        spawn-sh-at-startup "dbus-update-activation-environment --all --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_ID"
        spawn-sh-at-startup "uwsm finalize"

      ''
      + builtins.concatStringsSep "\n" (map (x: ''spawn-at-startup "${x}"'') [
        dunst
        nm-applet
        awww-daemon
        wallI
        xwayland-satellite
      ]);
  };
}
