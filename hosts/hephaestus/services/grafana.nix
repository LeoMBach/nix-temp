{ config, lib, ... }:

let
  settings = import ../../../secrets/hephaestus/settings.nix;
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
