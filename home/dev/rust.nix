{pkgs, ...}: {
  home.packages = with pkgs; [
    (
      if builtins.hasAttr "rust-bin" pkgs
      then
        rust-bin.selectLatestNightlyWith (toolchain:
          toolchain.default.override {
            extensions = ["rust-src"];
          })
      else cargo
    )
    rust-analyzer
    cargo-make
  ];
}
