{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services = {
    gitea = {
      enable = true;

      appName = "Gitea";
      disableRegistration = true;
      useWizard = true;

      domain = globalConf.git.domain;
      rootUrl = "https://${globalConf.git.domain}:${toString globalConf.git.port}";

      cookieSecure = true;

      database = {
        name = "gitea";
        user = "gitea";
        type = "postgres";
        port = "5432";
        createDatabase = false;
      };

      dump = {
        enable = true;
        interval = "02:00";
      };
    };

    nginx.virtualHosts."${globalConf.git.domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = { proxyPass = "http://127.0.0.1:${toString globalConf.git.port}"; };
    };
  };
}
