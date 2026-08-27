{pkgs, ...}: {
  imports = [./binds.nix];

  xdg.configFile."red/start.sh" = let
    script = pkgs.writeShellScript "red-start.sh" ''
      if [[ -v RED_PARENT_WAYLAND_DISPLAY ]]; then
          exit 0
      fi

      dbus-update-activation-environment --systemd \
        DISPLAY \
        RED_SOCKET \
        WAYLAND_DISPLAY \
        XDG_CURRENT_DESKTOP \
        XDG_SESSION_ID

      uwsm finalize

      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1&
      . $XDG_CONFIG_HOME/red/binds.sh
    '';
  in {
    source = script;
    executable = true;
  };

  home.packages = [
    (pkgs.writers.writeBashBin "rd" ''
      uwsm start red
    '')
  ];
}
