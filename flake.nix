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
        ./checks
        ./templates
      ];
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    hyprpicker = {
      type = "git";
      url = "https://github.com/hyprwm/hyprpicker";
      rev = "444c40e5e3dc4058a6a762ba5e73ada6d6469055";
    };

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
    gazi.url = "github:crolbar/gazi";
    gql.url = "github:crolbar/gql";
    salg.url = "github:crolbar/salg";
    go29.url = "github:crolbar/go29";
    auvi.url = "github:crolbar/auvi";
    vbz.url = "github:crolbar/vbz";
    stray.url = "github:crolbar/stray";

    nvim_conf = {
      url = "git+file:./home/editors/neovim/nvim";
      flake = false;
    };

    neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
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

    leftwm-flake.url = "github:crolbar/leftwm-flake";

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

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    ghostty.url = "github:ghostty-org/ghostty";
  };
}
