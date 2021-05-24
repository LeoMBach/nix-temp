{ config, lib, ... }:

{
  services = {
    postgresql = {
      enable = true;

      ensureDatabases = [
        "gitea"
        "nextcloud"
        "grafana"
      ];

      ensureUsers = [
        {
          name = "dba";
          ensurePermissions = { "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES"; };
        }
        {
          name = "grafana";
          ensurePermissions = { "DATABASE grafana" = "ALL PRIVILEGES"; };
        }
        # {
        #   name = "nextcloud";
        #   ensurePermissions = { "DATABASE nextcloud" = "ALL PRIVILEGES"; };
        # }
      ];
    };

    postgresqlBackup = {
      enable = true;
      startAt = "*-*-* 02:00:00"; # Should happen before borg
    };
  };
}
