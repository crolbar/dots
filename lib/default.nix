args @ {withSystem, ...}: let
  clib =
    {}
    // (import ./sys_builders.nix args)
    // (import ./writers.nix)
    // (import ./bindsTranslator.nix args)
    // (import ./utils.nix args);
in {
  _module.args.clib = clib;
  flake.clib = clib;
}
