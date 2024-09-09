{pkgs, ...}: {
  services.picom = {
    enable = false;
    backend = "glx";
    vSync = true;
  };

  home.packages = [pkgs.picom];
  xdg.configFile."picom/picom.conf".text = ''
    backend = "glx";
    vsync = true;
  '';
}
