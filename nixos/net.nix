{
    networking.hostName = "crowbar"; 
    networking.networkmanager.enable = true;

    networking.firewall = {
        enable = true;
        #allowedTCPPorts = [ 80 8000 ];
    };

    services.nginx = {
        enable = false;
        virtualHosts."crowbar" = {
            root = "/var/www/nginx";
            locations."/" = {
                extraConfig = "try_files $uri /index.html;";
            };
        };
    };
}
