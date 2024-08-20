{pkgs, ...}: {
  system.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.lix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      min-free = "${toString (5 * 1024 * 1024 * 1024)}";
      max-jobs = "auto";
      warn-dirty = false;
      http-connections = 30;
      builders-use-substitutes = true;
      trusted-users = ["root" "@wheel"];

      extra-platforms = ["aarch64_linux"];

      # if any substituters are added they will be available for usage on
      # the next system rebuild and will not be in the system rebuild that they are added
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
        "https://crolbar.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "crolbar.cachix.org-1:THfEkGfnXN+9c95nD3TAS8lGE27rDeFt/ZmNCiin4Is="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };

    optimise.automatic = true;

    daemonIOSchedClass = "idle";
    daemonCPUSchedPolicy = "idle";
  };
}
