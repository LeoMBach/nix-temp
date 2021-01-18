{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.rclone-mount;

  mkRcloneMount = name: cfg:
    nameValuePair "rclone-mount-${name}" {
      description = "rclone mount ${name}";
      path = [ pkgs.rclone ];
      preStart = "mkdir -p ${cfg.mountPath}";
      serviceConfig = {
        Type = "simple";
        Environment = "PATH=$PATH:/run/current-system/sw/bin:/run/wrappers/bin/fusermount";
        ExecStart = [''
          /run/current-system/sw/bin/rclone mount \
            --config=${cfg.configPath} \
            --allow-other \
            --cache-tmp-upload-path=/tmp/rclone/upload \
            --cache-chunk-path=/tmp/rclone/chunks \
            --cache-db-path=/tmp/rclone/db \
            --cache-dir=/tmp/rclone/vfs \
            --vfs-cache-mode=full \
            --stats=60s \
            ${cfg.remote} ${cfg.mountPath}
        ''];
        ExecStop = "/run/wrappers/bin/fusermount -u ${cfg.mountPath}";
        Restart = "always";
        RestartSec = "10";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
    };
in {
  options.services.rclone-mount.mounts = mkOption {
    default = {};
    type = types.attrsOf (types.submodule (
      { name, ... }: {
        options = {
          remote = mkOption {
            type = types.str;
            description = "Name of the remote to mount.";
            example = "dropbox:";
          };

          configPath = mkOption {
            type = types.str;
            description = "Absolute path to rclone.conf.";
            example = "/root/.config/rclone/rclone.conf";
          };

          mountPath = mkOption {
            type = types.str;
            description = "Absolute path to target mount directory.";
            example = "/mnt/mymount";
          };
        };
      }
    ));
  };

  config = mkIf (with config.services.rclone-mount; mounts != {})
    (with config.services.rclone-mount; {
      environment.systemPackages = [ pkgs.rclone ];
      systemd.services = mapAttrs' mkRcloneMount mounts;
    });
}
