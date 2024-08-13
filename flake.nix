{
  description = "crolbar's NixOS & Home Manager configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        ./home
        ./hosts
        ./devShell.nix
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

    nvim_conf = {
      url = "git+file:./home/cli/neovim/nvim";
      flake = false;
    };

    swww.url = "github:LGFae/swww";
    zellij.url = "github:a-kenji/zellij-nix";

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun.url = "github:anyrun-org/anyrun";

    microfetch.url = "github:notashelf/microfetch";

    nix-gaming.url = "github:fufexan/nix-gaming";
  };
}
