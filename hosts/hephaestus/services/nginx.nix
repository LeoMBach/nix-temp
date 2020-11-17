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
        locations."/" = { proxyPass = "https://127.0.0.1:3000"; };
      };

      "${settings.mediaDomain}" = {
        locations."/" = { proxyPass = "https://127.0.0.1:8920"; };
      };

      "${settings.nextcloudDomain}" = {
        locations."/" = { proxyPass = "https://127.0.0.1:443"; };
      };
    };
  };
}
