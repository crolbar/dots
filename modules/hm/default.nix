{
  spicetify-nix,
  leftwm-flake,
  anyrun,
  agenix,
  ...
}: let
  defaultHmMod = flake:
    flake.homeManagerModules.default;
in {
  imports = [
    ./cbinds.nix
    (defaultHmMod leftwm-flake)
    (defaultHmMod spicetify-nix)
    (defaultHmMod anyrun)
    (defaultHmMod agenix)
  ];
}
