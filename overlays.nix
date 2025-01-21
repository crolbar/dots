{
  inputs',
  rust-overlay,
  ristate,
  emacs-overlay,
  ...
}: let
  ovrls =
    builtins.foldl' (acc: elem: acc // elem) {}
    (
      map (pname: {
        "${pname}" = inputs'."${pname}".packages.default;
      }) ["dapu" "matm" "tt-rs" "npassm" "lobster" "swww" "gazi" "gql"]
    );
in {
  nixpkgs.overlays = [
    (final: prev: ovrls)
    ristate.overlays.default
    rust-overlay.overlays.default
    emacs-overlay.overlays.default
  ];
}
