{config, ...}: let
  forgejo_port = config.services.forgejo.settings.server.HTTP_PORT;
in {
  services.nginx = {
    enable = true;
    virtualHosts."screw.rs" = {
      extraConfig = ''
        client_max_body_size 512M;
      '';

      locations."/dns" = {
        # TODO: do better
        return = "http://screw.rs:9002";
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString forgejo_port}";
      };
    };
  };
}
