{
  services.tailscale = {
    enable = true;
    extraDaemonFlags = [
      "--no-logs-no-support"
    ];
    openFirewall = true;
  };
}
