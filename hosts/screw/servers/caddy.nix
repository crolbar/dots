{
  config,
  lib,
  ...
}: let
  forgejo_port = config.services.forgejo.settings.server.HTTP_PORT;
  grafana_port = config.services.grafana.settings.server.http_port;
  kiwix_port = config.services.kiwix-serve.port;
in {
  services.caddy = {
    enable = true;

    virtualHosts = let
      forgejo.extraConfig = ''
        tls internal
        reverse_proxy 0.0.0.0:${toString forgejo_port}

        request_body {
          max_size 512MB
        }
      '';
      grafana.extraConfig = ''
        tls internal
        reverse_proxy 0.0.0.0:${toString grafana_port} {
          header_up Host {host}
        }
      '';
      kiwix.extraConfig = ''
        tls internal
        reverse_proxy 0.0.0.0:${toString kiwix_port} {
          header_up Host {host}
        }
      '';
      freshrss.extraConfig = ''
        tls internal
        root * ${config.services.freshrss.package}/p
        php_fastcgi unix/${config.services.phpfpm.pools.freshrss.socket} {
          env FRESHRSS_DATA_PATH ${config.services.freshrss.dataDir}
        }
        file_server
      '';
    in {
      "screw.rs git.screw.rs screw.sh git.screw.sh" = forgejo;
      "graf.screw.rs graf.screw.sh" = grafana;
      "kiwix.screw.rs kiwix.screw.sh" = kiwix;
      "rss.screw.rs rss.screw.sh" = lib.mkForce freshrss;
    };
  };
}
