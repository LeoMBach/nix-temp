{ config, lib, pkgs, ... }:

{
  imports = [ ../../../modules/rclone-mount.nix ];

  services.rclone-mount.mounts.plex = {
    remote = "storage:Plex";
    configPath = "/etc/nixos/nixos-config/secrets/dionysus/rclone.config";
    mountPath = "/mnt/plex";
  };
}
