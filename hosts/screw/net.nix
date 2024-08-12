{
  networking = {
    networkmanager = {
      enable = true;
      insertNameservers = ["127.0.0.1" "9.9.9.9"];
    };

    interfaces.end0 = {
      ipv4.addresses = [
        {
          address = "192.168.1.11";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.1.1";
      interface = "end0";
    };

    firewall = {
      enable = false;
      allowedTCPPorts = [22 80 3000 53];
    };
  };
}
