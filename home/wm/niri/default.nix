{
  pkgs,
  inputs',
  ...
}: {
  imports = [
    ./binds.nix
    ./settings.nix
    ./eww

    ../share/wayland
    ../share/dunst.nix
    ../share/wall
    ../share/scripts
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    # package = inputs'.niri.packages.niri-stable;
  };

  systemd.user.targets.niri-session = {
    Unit = {
      Description = "niri compositor session";
      Documentation = ["man:systemd.special(7)"];
      BindsTo = ["graphical-session.target"];
      Wants = [
        "graphical-session-pre.target"
        "xdg-desktop-autostart.target"
      ];
      After = ["graphical-session-pre.target"];
      Before = ["xdg-desktop-autostart.target"];
    };
  };
}
