{ config, lib, pkgs, ... }:

with lib;

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud21;
      autoUpdateApps.enable = false;

      hostName = globalConf.nextcloud.domain;
      https = true;

      config = {
        adminuser = "admin";
        adminpass = readFile ../../../secrets/dionysus/nextcloud/admin.pass;

        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        dbuser = "nextcloud";
      };
    };

    nginx.virtualHosts."${globalConf.nextcloud.domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = { proxyPass = "http://127.0.0.1:443"; };
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
