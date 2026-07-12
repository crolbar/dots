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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

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
    clare.url = "github:crolbar/clare";
    discaml.url = "github:crolbar/discaml";
    brok.url = "github:crolbar/brok";

    leftwm-flake.url = "github:crolbar/leftwm-flake";
    ristate.url = "github:crolbar/ristate";

    nvim_conf = {
      url = "git+file:./home/editors/neovim/nvim";
      flake = false;
    };

    # neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";

    # schizofox = {
    #   url = "github:schizofox/schizofox";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-parts.follows = "flake-parts";
    #   };
    # };
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";

    darkmatter-grub-theme = {
      url = "github:crolbar/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "hm";
        darwin.follows = "";
      };
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };
}
