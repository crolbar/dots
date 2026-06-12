{config, ...}: let
  caddyEnabled = config.services.caddy.enable;
in {
  services.freshrss = {
    enable = true;
    passwordFile = config.age.secrets.freshRSSpass.path;
    webserver = "caddy";
    baseUrl = let
      protocol =
        if caddyEnabled
        then "https"
        else "http";
    in "${protocol}://rss.screw.rs";
    authType = "none";
    virtualHost = "rss.screw.rs rss.screw.sh";
  };
}
