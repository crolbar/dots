{
  pkgs,
  lib,
  clib,
  ...
} @ attr: let
  browser = "Twilight";
  music_player = "Music Player Daemon";
  args = {inherit browser music_player;} // attr;
in {
  imports = [
    (import ./volume.nix args)
    (import ./player.nix args)
    (import ./brok.nix args)
    ./dcc.nix
  ];

  home.file."scripts/eww/weather".source =
    (clib.writers pkgs).writeC "weather" ./weather.c;
}
