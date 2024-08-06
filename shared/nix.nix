{
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      cores = 8;

      builders-use-substitutes = true;
      trusted-substituters = [ "https://anyrun.cachix.org" ];
      substituters = [ "https://anyrun.cachix.org" ];
      trusted-public-keys = [
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      ];
    };

    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 15d";
  };
}
