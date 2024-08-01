{
  rust-overlay,
  nur,
  dapu,
  matm,
  tt-rs,
  lobster,
  npassm,
  ...
}: let
  ovrls =
    builtins.foldl' (acc: elem: acc // elem) {}
    (
      map (pkg: let
        pname = pkg.defaultPackage.x86_64-linux.pname;
      in {
        "${pname}" = pkg.defaultPackage.x86_64-linux;
      })
      [dapu matm tt-rs npassm]
    );
in {
  nixpkgs.overlays = [
    (final: prev:
      {
        lobster = lobster.packages.x86_64-linux.default;
      }
      // ovrls)
    rust-overlay.overlays.default
    nur.overlay
  ];
}
