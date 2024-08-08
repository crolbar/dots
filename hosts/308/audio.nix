{nix-gaming, ...}: {
  imports = [nix-gaming.nixosModules.pipewireLowLatency];

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency.enable = true;
  };
}
