{
  networking = {
    networkmanager = {
      enable = true;
      insertNameservers = ["192.168.1.11"];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };
}
