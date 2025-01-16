args @ {withSystem, ...}: let
  clib =
    {}
    // (import ./sys_builders.nix args)
    // (import ./writers.nix)
    // {genBinds = import ./bindsGenerator.nix;};
in {
  _module.args.clib = clib;
  flake.clib = clib;
}
