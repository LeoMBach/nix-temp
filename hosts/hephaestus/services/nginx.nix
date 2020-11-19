{ config, lib, ... }:

let
  settings = import ../../../secrets/hephaestus/settings.nix;
in
{
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "${settings.gitDomain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:3000"; };
      };

      "${settings.mediaDomain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:8096"; };
      };

      "${settings.nextcloudDomain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = { proxyPass = "http://127.0.0.1:443"; };
      };
    };
  };
}
