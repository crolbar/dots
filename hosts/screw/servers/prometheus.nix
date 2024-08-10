{
  services.prometheus = {
    enable = true;
    configText = ''
      global:
        scrape_interval:     15s
        evaluation_interval: 15s

      scrape_configs:
        - job_name: 'localhost'

          static_configs:
          - targets: ['localhost:4000']
    '';
  };
}
