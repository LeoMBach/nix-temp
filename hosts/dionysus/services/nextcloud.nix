{ config, pkgs, lib, ... }:

let
  settings = import ../../../secrets/dionysus/settings.nix;
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud20;
    autoUpdateApps.enable = false;

    hostName = settings.nextcloud.domain;
    https = true;

    config = {
      adminuser = "admin";
      adminpass = "admin";
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
