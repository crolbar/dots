{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;

    networkmanager = {
      enable = true;
      insertNameservers = ["192.168.1.11"];
    };
    wireless.userControlled.enable = false;

    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };
}
