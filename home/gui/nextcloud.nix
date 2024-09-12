{pkgs, ...}: {
  home.packages = [pkgs.nextcloud-client];
  services.nextcloud-client = {
    enable = true;
  };
}
