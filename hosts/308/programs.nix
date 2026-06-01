{pkgs, ...}: {
  programs = {
    # hyprland = {
    #   enable = true;
    #   withUWSM = true;
    # };
    sway.enable = true;
    niri.enable = true;
    dconf.enable = true;
    uwsm = {
      enable = true;

      waylandCompositors.niri = {
        binPath = "/run/current-system/sw/bin/niri";
        comment = "Niri (UWSM)";
        extraArgs = ["--session"];
        prettyName = "Niri";
      };
    };
  };
  services.dbus.implementation = "broker";

  environment = {
    systemPackages = with pkgs; [
      nvtopPackages.full # gpu monitor
      looking-glass-client

      # xfce.xfce4-systemload-plugin
    ];
  };
}
