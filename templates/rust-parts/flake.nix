{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    overlays = [(import inputs.rust-overlay)];
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {system, ...}: let
        pkgs = import inputs.nixpkgs {inherit system overlays;};

        rust = pkgs.rust-bin.stable.latest.default.override {
          extensions = ["rust-src" "rust-analyzer"];
        };
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            rust

            pkg-config
          ];
        };

        packages = {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "rust-parts-template";
            version = "0.1";

            src = ./.;

            #cargoHash = "";
            cargoLock.lockFile = ./Cargo.lock;
          };
        };
      };
    };
}
