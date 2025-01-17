{
  clib,
  pkgs,
  ...
}: let
  # names are Properties.application.name from `pactl list sink-inputs`
  musicPlayer = "Music Player Daemon";
  #musicPlayer = "spotify";
  browser = "Firefox";
in {
  imports = [
    #./dispatch.nix
    ./default-sink.nix
    ./rgb.nix
    (import ./volume.nix {inherit pkgs browser musicPlayer;})
  ];

  xdg.configFile."hypr/scripts/dispatch".source =
    (clib.writers pkgs).writeC "dispatch" ./dispatch.c;
}
