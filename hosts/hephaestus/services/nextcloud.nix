{ config, lib, ... }:

{
  services.nextcloud = {
    enable = true;
    hostName = "cloud.lmgtb.dev";
    https = true;
    autoUpdateApps.enable = true;
    config = {
      adminuser = "admin";
      adminpass = "admin";

      dbtype = "pgsql";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbpass = "nextcloud";
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
