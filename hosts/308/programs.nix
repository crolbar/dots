{pkgs, ...}: {
  programs = {
    hyprland.enable = true;
    sway.enable = true;
  };

  #environment.defaultPackages = with pkgs; [
  #  xfce.xfce4-systemload-plugin
  #];
}
