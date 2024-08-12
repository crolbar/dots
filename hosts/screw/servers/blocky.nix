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
          blocks = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt"
            "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"

            "https://blocklistproject.github.io/Lists/ads.txt"
            "https://blocklistproject.github.io/Lists/porn.txt"
            "https://blocklistproject.github.io/Lists/phishing.txt"
            "https://blocklistproject.github.io/Lists/malware.txt"
            "https://blocklistproject.github.io/Lists/tracking.txt"
          ];

          cringe = [
            ''
              /youtube/
            ''
          ];
        };
        clientGroupsBlock.default = ["blocks" "cringe"];
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
