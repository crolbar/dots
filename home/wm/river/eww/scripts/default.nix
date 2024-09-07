{
  clib,
  pkgs,
  ...
}: {
  imports = [
    ./ristate.nix
  ];

  xdg.configFile."river/eww/scripts/ristate".source =
    (clib.writers pkgs).writeC "ristate" ./ristate.c;
}
