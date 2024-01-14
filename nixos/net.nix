{
    networking.hostName = "plier"; 
    networking.networkmanager = {
        enable = true;
        insertNameservers = [ "192.168.1.11" ];
    };


    networking.firewall = {
        enable = true;
        #allowedTCPPorts = [ ];
    };

    services.nginx = {
        enable = false;
        virtualHosts."plier" = {
            root = "/var/www/nginx";
            locations."/" = {
                extraConfig = "try_files $uri /index.html;";
            };
        };
    };
}
