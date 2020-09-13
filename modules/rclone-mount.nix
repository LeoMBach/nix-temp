{ config, lib, ... }:

with lib;

let
  cfg = config.services.rclone-mount;
in {
    options.services.rclone-mount = {
        enable = mkEnableOption "rclone mount service";
        description = mkOption {
            type = types.str;
            default = "";
        };
        remoteName = mkOption {
            type = types.str;
        };
        mountDir = mkOption {
            type = types.str;
            description = "The target mount directory. Will be created if it does not exist.";
            default = "/mnt/dropbox"; # TODO: Dynamic mount dir
        };
        configPath = mkOption {
            type = types.str;
            description = "Absolute path to rclone.conf.";
        };
    };

    config = {
        systemd.services.rclone-mount = {
            description = "${cfg.description}";
            after = [ "network-online.target" ];
            preStart = "mkdir -p ${cfg.mountDir}";
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
                        --stats=0 \
                        ${cfg.remoteName} ${cfg.mountDir}
                ''];
                ExecStop = "/run/wrappers/bin/fusermount -u ${cfg.mountDir}";
                Restart = "always";
                RestartSec = "10";
            };
            wantedBy = [ "multi-user.target" ];
        };
    };
}
