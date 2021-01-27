{ config, lib, ... }:

let
  settings = import ../../../secrets/dionysus/settings.nix;
in
{
  services.grafana = {
    enable = true;
    domain = "${settings.grafanaDomain}";
    port = settings.grafana.port;

    database = {
      type = "postgres";
      host = "/run/postgresql";
      user = "grafana";
    };
  };
}
