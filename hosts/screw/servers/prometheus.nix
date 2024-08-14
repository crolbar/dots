{
  services.prometheus = {
    enable = true;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd"];
        port = 9100;
      };
    };

    globalConfig = {
      scrape_interval = "15s";
      evaluation_interval = "15s";
    };

    scrapeConfigs = [
      {
        job_name = "localhost";
        static_configs = [
          {
            targets = [
              "localhost:4000"
              "localhost:3000"
              "localhost:9100"
            ];
          }
        ];
      }
    ];
  };
}
