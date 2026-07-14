{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [
    leftwm
    nvtopPackages.intel
  ];
  programs = {
    # hyprland.enable = true;
    # river-classic.enable = true;
    niri = {
      enable = true;
      package = pkgs.callPackage ../../derivations/niri.nix {};
    };
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
