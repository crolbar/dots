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

    dapu = {
      url = "github:crolbar/dapu";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        rust-overlay.follows = "rust-overlay";
      };
    };

    matm = {
      url = "github:crolbar/matm";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        rust-overlay.follows = "rust-overlay";
      };
    };

    tt-rs = {
      url = "github:crolbar/tt-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };

    npassm = {
      url = "github:crolbar/npassm";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

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
  };
}
