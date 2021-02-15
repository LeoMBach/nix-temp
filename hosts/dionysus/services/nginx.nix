{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "${globalConf.dashboard.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:${builtins.toString(globalConf.dashboard.port)}"; };
      };

      "${globalConf.git.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:${builtins.toString(globalConf.git.port)}"; };
      };

      "${globalConf.media.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:8096"; };
      };

      "${globalConf.nextcloud.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:443"; };
      };

      "${globalConf.portainer.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:${builtins.toString(globalConf.portainer.port)}"; };
      };

      "${globalConf.wiki.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:${builtins.toString(globalConf.wiki.port)}"; };
      };
    };
  };
}
