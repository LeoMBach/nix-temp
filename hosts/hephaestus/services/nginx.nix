{ config, lib, ... }:

{
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "GIT_DOMAIN" = {
        locations."/" = { proxyPass = "https://127.0.0.1:3000"; };
      };
    };
  };
}
