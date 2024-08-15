args @ {withSystem, ...}: let
  clib = {} // (import ./sys.nix args);
in {
  _module.args.clib = clib;
}
