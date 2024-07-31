{
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      cores = 8;
    };

    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 15d";
  };
}
