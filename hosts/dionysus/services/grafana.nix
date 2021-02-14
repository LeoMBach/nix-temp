{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services.grafana = {
    enable = true;
    domain = "${globalConf.grafanaDomain}";
    port = globalConf.grafana.port;

    database = {
      type = "postgres";
      host = "/run/postgresql";
      user = "grafana";
    };
  };
}
