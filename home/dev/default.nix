{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd
    nil
    alejandra

    lua
    lua-language-server

    nodejs
    yarn

    clang-tools
    gcc
    gnumake


    (
      rust-bin.selectLatestNightlyWith (toolchain:
        toolchain.default.override {
          extensions = ["rust-src"];
        })
    )
    rust-analyzer
    cargo-make


    (python311.withPackages (ppkgs:
      with ppkgs; [
        requests
        pip
      ]))
    pyright

    nodePackages_latest.bash-language-server
    nodePackages_latest.vscode-langservers-extracted
  ];
}
