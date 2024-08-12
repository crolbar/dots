{
  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53;
        http = 4000;
      };

      upstreams = {
        groups = {
          default = [
            "https://dns.quad9.net/dns-query"
            "https://dns.digitale-gesellschaft.ch/dns-query"
            "https://cloudflare-dns.com/dns-query"
          ];
        };
      };

      bootstrapDns = {
        upstream = "https://dns.quad9.net/dns-query";
        ips = [
          "9.9.9.9"
          "149.112.112.112"
        ];
      };

      prometheus.enable = true;

      blocking = {
        denylists = {
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
          adult = [
            "https://blocklistproject.github.io/Lists/porn.txt"
          ];
        };
        clientGroupsBlock.default = ["ads" "adult"];
      };

      customDNS = {
        mapping = {
          "screw.rs" = "192.168.1.11";
          screw = "192.168.1.11";
          crol = "192.168.1.12";
          plier = "192.168.1.27";
        };
      };
    };
  };
}
