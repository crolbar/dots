{
  pkgs,
  clib,
  ...
}: let
  browser = "Twilight";
  music_player = "Music Player Daemon";
  args = {inherit pkgs browser music_player;};
in {
  imports = [
    (import ./volume.nix args)
    (import ./player.nix args)
    ./dcc.nix
  ];

  home.file."scripts/eww/weather".source =
    (clib.writers pkgs).writeC "weather" ./weather.c;
}
