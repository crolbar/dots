{
  spicetify-nix,
  leftwm-flake,
  agenix,
  niri,
  ...
}: let
  defaultHmMod = flake:
    flake.homeManagerModules.default;
in {
  imports = [
    ./cbinds.nix
    (defaultHmMod leftwm-flake)
    (defaultHmMod spicetify-nix)
    (defaultHmMod agenix)
    niri.homeModules.niri
  ];
}
