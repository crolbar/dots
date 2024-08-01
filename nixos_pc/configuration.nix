{
  config,
  pkgs,
  ...
}: {
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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "floorp";
    TERMINAL = "alacritty";
  };

  nixpkgs.config.pulseaudio = true;
  hardware = {
    pulseaudio = {
      package = pkgs.pulseaudioFull;
      enable = true;
      support32Bit = true;
      daemon.config = {
        flat-volumes = "yes";
      };
    };

    bluetooth.enable = false;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      nvidiaSettings = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };
  services.xserver.videoDrivers = ["nvidia"];

  services.playerctld.enable = true;

  services.pipewire = {
    enable = true;
    #alsa.enable = true;
    #alsa.support32Bit = true;
    #jack.enable = true;
    #pulse.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  fileSystems."/arch" = {
    device = "/dev/disk/by-uuid/4a7b5c17-3256-4f7c-b475-56d85727f6f8";
    fsType = "ext4";
  };
}
