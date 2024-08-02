{
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./hosts
        ./home
      ];
    };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nur.url = "github:nix-community/NUR";

    yazi.url = "github:sxyazi/yazi";

    dapu.url = "github:crolbar/dapu";
    matm.url = "github:crolbar/matm";
    tt-rs.url = "github:crolbar/tt-rs";
    npassm.url = "github:crolbar/npassm";

    lobster.url = "github:justchokingaround/lobster";

    rust-overlay.url = "github:oxalica/rust-overlay";

    swww.url = "github:LGFae/swww";
    zellij.url = "github:a-kenji/zellij-nix";
  };
}
