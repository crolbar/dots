{
  rust-overlay,
  nur,
  dapu,
  matm,
  tt-rs,
  lobster,
  npassm,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      dapu = dapu.defaultPackage.x86_64-linux;
      matm = matm.defaultPackage.x86_64-linux;
      tt-rs = tt-rs.defaultPackage.x86_64-linux;
      npassm = npassm.defaultPackage.x86_64-linux;
      lobster = lobster.packages.x86_64-linux.lobster;
    })
    rust-overlay.overlays.default
    nur.overlay
  ];
}
