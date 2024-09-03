{pkgs, ...}: {
  imports = [
    ./anyrun.nix
  ];
  home.packages = with pkgs; [
    swww
    hyprpicker
    wl-clipboard
    grim
    slurp
    wayland-utils

    nwg-look # maybe unneeded
  ];

  xdg.desktopEntries = {
    hyprpicker = {
      name = "HyprPicker";
      genericName = "Terminal";
      exec = "sh -c \"wl-copy \\$(hyprpicker)\"";
      terminal = false;
      icon = "xcolor";
    };
  };

  programs = {
    swaylock.enable = true;
  };
}
