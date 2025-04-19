{config, ...}: let
  forgejo_port = config.services.forgejo.settings.server.HTTP_PORT;
  grafana_port = config.services.grafana.settings.server.http_port;
in {
  services.nginx = {
    enable = true;
    virtualHosts = let
      root = {
        extraConfig = ''
          client_max_body_size 512M;
        '';
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString forgejo_port}";
        };
      };
    in {
      "screw.rs" = root;
      "screw.sh" = root;

      "graf.screw.rs" = {
        locations."/" = {
          proxyPass = "http://0.0.0.0:${toString grafana_port}";
          extraConfig = "proxy_set_header Host $host;";
        };
      };
    };
  };
}
