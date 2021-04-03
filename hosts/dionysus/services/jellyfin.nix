{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services = {
    jellyfin.enable = true;

    nginx.virtualHosts."${globalConf.media.domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = { proxyPass = "http://127.0.0.1:8096"; };
    };
  };
}
