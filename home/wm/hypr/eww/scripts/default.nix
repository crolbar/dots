{
  clib,
  pkgs,
  ...
}: let
  speakerSink = "GP106";
in {
  imports = [
    #./workspace_scroll.nix # backup scripts if the C onces break
    #./hyprland.nix
    (import ./pulse.nix {inherit pkgs speakerSink;})
  ];

  xdg.configFile."hypr/eww/scripts/hyprland".source =
    (clib.writers pkgs).writeC "hyprland" ./hyprland.c;

  xdg.configFile."hypr/eww/scripts/workspace_scroll".source =
    (clib.writers pkgs).writeC "workspace_scroll" ./workspace_scroll.c;
}
