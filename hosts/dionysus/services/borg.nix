{ config, lib, ... }:

let
  settings = import ../../../secrets/dionysus/settings.nix;
in
{
  services.borgbackup.jobs = {
    services = {
      paths = [
        "/var/lib/gitea"
        "/var/lib/jellyfin"
        "/var/lib/nextcloud"
        "/var/backup/postgresql"
      ];

      repo = "/var/backup/borg";
      doInit = true;
      extraCreateArgs = "--stats";

      # TODO: Would be better to wait for postgresqlBackup completion
      startAt = "*-*-* 03:00:00";
      prune.keep = {
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 1;
      };

      compression = "auto,zstd,19";

      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ../../../secrets/dionysus/borg/services-pass.txt";
      };

    };
  };
}