{pkgs, ...}: {
  home.file.".xinitrc".text = ''
    exec ${pkgs.xfce.xfce4-session}/bin/startxfce4
  '';
}
