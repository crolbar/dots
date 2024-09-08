{
  description = "crolbar's NixOS & Home Manager configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        ./lib
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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    yazi.url = "github:sxyazi/yazi";

    # not sure how caching works exacly but with my testing I find out that:
    # If in the input flake the nixpkgs are overritten for all other inputs (not 100% sure but in pkgs that I don't override them it always triggers compilation)
    # and in your flake (in which you use the flake as an input) you don't override nixpkgs
    # you will be able to use the cache but if you overrite nixpkgs there is a chance that the
    # store hash will change only because you overrite them and you will not be able to use the cache.
    dapu.url = "github:crolbar/dapu";
    matm.url = "github:crolbar/matm";
    tt-rs.url = "github:crolbar/tt-rs";
    npassm.url = "github:crolbar/npassm";

    lobster = {
      url = "github:justchokingaround/lobster";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nvim_conf = {
      url = "git+file:./home/cli/neovim/nvim";
      flake = false;
    };

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    microfetch = {
      url = "github:notashelf/microfetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };

    leftwm.url = "github:leftwm/leftwm";

    ristate = {
      url = "github:crolbar/ristate";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        rust-overlay.follows = "rust-overlay";
      };
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "hm";
        darwin.follows = "";
      };
    };
  };
}
