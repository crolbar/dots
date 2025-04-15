{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;

    networkmanager = {
      enable = true;
      insertNameservers = ["192.168.1.11"];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [22 6742];
    };
  };
}
