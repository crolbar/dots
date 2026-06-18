{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [leftwm];
  programs = {
    # hyprland.enable = true;
    # river-classic.enable = true;
    niri.enable = true;
    uwsm = {
      enable = true;

      waylandCompositors.niri = {
        binPath = "/run/current-system/sw/bin/niri";
        comment = "Niri (UWSM)";
        extraArgs = ["--session"];
        prettyName = "Niri";
      };
    };
  };
}
