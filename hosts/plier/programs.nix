{
  pkgs,
  red,
  ...
}: {
  imports = [red.nixosModules.default];
  environment.defaultPackages = with pkgs; [
    leftwm
    nvtopPackages.intel
  ];
  programs = {
    # hyprland.enable = true;
    # river-classic.enable = true;
    red.enable = true;
    niri = {
      enable = true;
      package = pkgs.callPackage ../../derivations/niri.nix {};
    };
    uwsm.enable = true;
  };
}
