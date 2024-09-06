{
  pkgs,
  clib,
  ...
}: let
  browser = "Firefox";
  music_player = "spotify";
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
