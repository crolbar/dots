{
  nix-gaming,
  pkgs,
  ...
}: {
  imports = [nix-gaming.nixosModules.platformOptimizations];

  environment.defaultPackages = [pkgs.lutris];

  services.auto-cpufreq.enable = true;

  programs = {
    steam = {
      enable = true;

      platformOptimizations.enable = true;

      remotePlay.openFirewall = false;

      extraCompatPackages = [pkgs.proton-ge-bin.steamcompattool];
      package = pkgs.steam-small.override {
        extraEnv = {
          MANGOHUD = true;
          # adding `windows` fixes "Failed to initialize dependencies" error on sea of theves (probably on other EAC games too)
          # https://www.reddit.com/r/linux_gaming/comments/1cvrvyg/psa_easy_anticheat_eac_failed_to_initialize/
          SDL_VIDEODRIVER = "x11,wayland,windows"; 
        };
        extraLibraries = ps: with ps; [atk];
      };
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 15;
          softrealtime = "auto";
        };

        custom = {
          start = "sudo auto-cpufreq --force performance && ${pkgs.libnotify}/bin/notify-send 'GameMode active'";
          end = "sudo auto-cpufreq --force reset && ${pkgs.libnotify}/bin/notify-send 'GameMode inactive'";
        };
      };
    };
  };
}
