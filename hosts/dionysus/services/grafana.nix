{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services.nginx.virtualHosts."${globalConf.grafana.domain}" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = { proxyPass = "http://127.0.0.1:${toString globalConf.grafana.port}"; };
  };
}
