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
        forceSSL = true;
        sslCertificate = /var/lib/acme/lmgtb.dev/fullchain.pem;
        sslCertificateKey = /var/lib/acme/lmgtb.dev/key.pem;
        locations."/" = { proxyPass = "http://127.0.0.1:3000"; };
      };

      "${settings.mediaDomain}" = {
        forceSSL = true;
        sslCertificate = /var/lib/acme/lmgtb.dev/fullchain.pem;
        sslCertificateKey = /var/lib/acme/lmgtb.dev/key.pem;
        locations."/" = { proxyPass = "http://127.0.0.1:8096"; };
      };

      "${settings.nextcloudDomain}" = {
        forceSSL = true;
        sslCertificate = /var/lib/acme/lmgtb.dev/fullchain.pem;
        sslCertificateKey = /var/lib/acme/lmgtb.dev/key.pem;
        locations."/" = { proxyPass = "http://127.0.0.1:443"; };
      };

      "${settings.wikiDomain}" = {
        forceSSL = true;
        sslCertificate = /var/lib/acme/lmgtb.dev/fullchain.pem;
        sslCertificateKey = /var/lib/acme/lmgtb.dev/key.pem;
        locations."/" = { proxyPass = "http://127.0.0.1:8080"; };
      };
    };
  };
}
