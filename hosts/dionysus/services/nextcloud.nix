{ config, pkgs, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud20;
    autoUpdateApps.enable = false;

    hostName = globalConf.nextcloud.domain;
    https = true;

    config = {
      adminuser = "admin";
      adminpassFile = "../../../secrets/dionysus/nextcloud/admin.pass";

      dbtype = "pgsql";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
