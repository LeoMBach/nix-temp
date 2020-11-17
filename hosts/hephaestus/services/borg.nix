{ config, lib, ... }:

let
  settings = import ../../../secrets/hephaestus/settings.nix;
in
{
  services.borgbackup.jobs = {
    services = {
      paths = [
        "/var/lib/gitea"
        "/var/lib/jellyfin"
        "/var/lib/nextcloud"
        "/var/lib/postgresql/${config.services.postgresql.package.psqlSchema}"
      ];

      repo = "/tmp/borg-repo";
      doInit = true;
      extraCreateArgs = "--stats";

      startAt = "daily";
      prune.keep = {
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 1;
      };

      compression = "auto,zstd,19";

      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ../../../secrets/hephaestus/borg/services-pass.txt";
      };

    };
  };
}
