{ config, pkgs, lib, ... }:

with lib;

let
  globalConf = import ../../../../secrets/dionysus/global-config.nix;
in
{
  services.grafana = {
    enable = true;
    domain = "${globalConf.grafana.domain}";
    port = globalConf.grafana.port;

    security = {
      adminUser = "admin";
      adminPassword = "${globalConf.grafana.password}";
    };

    provision = {
      enable = true;
      dashboards = [
        {
          name = "overview.json";
          folder = "Community";
          options.path = pkgs.writeTextDir "overview.json" (fileContents ./dashboards/node-exporter-full.json);
        }
      ];
      datasources = [
        {
          name = "prometheus";
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

  systemd.services.grafana = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
