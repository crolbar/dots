{config, ...}: {
  services.freshrss = {
    enable = true;
    passwordFile = config.age.secrets.freshRSSpass.path;
    baseUrl = "http://rss.screw.rs";
    virtualHost = "rss.screw.rs";
  };
}
