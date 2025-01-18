{
  clib,
  pkgs,
  ...
}: {
  imports = [
    #./dispatch.nix
  ];

  xdg.configFile."hypr/scripts/dispatch".source =
    (clib.writers pkgs).writeC "dispatch" ./dispatch.c;
}
