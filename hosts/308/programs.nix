{pkgs, ...}: {
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    sway.enable = true;
    dconf.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      nvtopPackages.full # gpu monitor

      # xfce.xfce4-systemload-plugin
    ];
  };
}
