{
  clib,
  pkgs,
  ...
}: let
  musicPlayer = "Music Player Daemon";
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
