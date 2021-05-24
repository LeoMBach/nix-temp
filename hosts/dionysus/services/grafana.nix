{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services = {
    grafana = {
      enable = true;
      domain = "${globalConf.grafana.domain}";
      port = globalConf.grafana.port;

      security = {
        adminUser = "admin";
        adminPassword = "${globalConf.grafana.password}";
      };

      provision = {
        enable = true;
        datasources = [
          {
            name = "dionysus";
            type = "prometheus";
            url = "http://localhost:${toString config.services.prometheus.port}";
          }
        ];
      };

      database = {
        type = "postgres";
        host = "/run/postgresql";
        user = "grafana";
        name = "grafana";
      };
    };

    prometheus = {
      enable = true;
      port = 9090;

      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = config.services.prometheus.port + 1;
        };
      };

      scrapeConfigs = [
        {
          job_name = "dionysus";
          static_configs = [{
            targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
          }];
        }
      ];
    };

    nginx.virtualHosts."${globalConf.grafana.domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = { proxyPass = "http://127.0.0.1:${toString globalConf.grafana.port}"; };
    };
  };

  systemd.services.grafana = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
