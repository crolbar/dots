{config, ...}: let
  forgejo_port = config.services.forgejo.settings.server.HTTP_PORT;
  grafana_port = config.services.grafana.settings.server.http_port;
in {
  services.nginx = {
    enable = true;
    virtualHosts."screw.rs" = {
      extraConfig = ''
        client_max_body_size 512M;
      '';

      locations."/dns" = {
        # TODO: do better
        return = "http://screw.rs:${toString grafana_port}";
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString forgejo_port}";
      };
    };
  };
}
