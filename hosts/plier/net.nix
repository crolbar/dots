{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;

    networkmanager = {
      enable = true;
      insertNameservers = ["9.9.9.9"];
    };
    wireless.userControlled.enable = false;

    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };
}
