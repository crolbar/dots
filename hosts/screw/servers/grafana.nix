{
  services.grafana = {
    enable = true;
    settings.server = {
      http_port = 9002;
      http_addr = "0.0.0.0";
    };
    provision.datasources.settings = {
      apiVersion = 1;
      deleteDatasources = [
        {
          name = "Prometheus";
          orgId = 1;
        }
      ];

      datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          orgId = 1;
          url = "http://localhost:9090";
          isDefault = true;
          jsonData = {
            graphiteVersion = "1.1";
            tlsAuth = false;
            tlsAuthWithCACert = false;
          };
          version = 1;
          editable = true;
        }
      ];
    };
  };
}
