{
  networking.hostName = "308";
  networking.networkmanager = {
    enable = true;
    insertNameservers = ["192.168.1.11"];
  };
  networking.wireless.userControlled.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22];
  };

  services.nginx = {
    enable = false;
    virtualHosts."crolbar" = {
      root = "/var/www/nginx";
      locations."/" = {
        extraConfig = "try_files $uri /index.html;";
      };
    };
  };
}
