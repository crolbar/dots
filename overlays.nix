{
  inputs',
  # rust-overlay,
  ristate,
  # emacs-overlay,
  ...
}: let
  ovrls =
    builtins.foldl' (acc: elem: acc // elem) {}
    (
      map (pname: {
        "${pname}" = inputs'."${pname}".packages.default;
      }) ["dapu" "matm" "tt-rs" "npassm" "gazi" "gql" "salg" "go29" "auvi" "vbz" "stray" "clare"]
    );
in {
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
    (final: prev: ovrls)
    ristate.overlays.default
    # rust-overlay.overlays.default
    # emacs-overlay.overlays.default
  ];
}
