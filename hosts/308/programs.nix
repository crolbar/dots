{
  pkgs,
  red,
  ...
}: {
  imports = [red.nixosModules.default];

  programs = {
    red.enable = true;
    sway.enable = true;
    niri = {
      enable = true;
      package = pkgs.callPackage ../../derivations/niri.nix {};
    };
    dconf.enable = true;
    uwsm.enable = true;
  };
  services.dbus.implementation = "broker";

  environment = {
    systemPackages = with pkgs; [
      nvtopPackages.full # gpu monitor
      looking-glass-client

      # xfce.xfce4-systemload-plugin

      (pkgs.writers.writeBashBin "wms" ''
        uwsm start -- select
      '')
    ];
  };
}
