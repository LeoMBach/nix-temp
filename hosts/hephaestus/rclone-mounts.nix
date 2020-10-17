{
  imports = [ ../../modules/rclone-mount.nix ];

  services = {
    rclone-mount.mounts = {
      media = {
        configPath = "${../../secrets/hephaestus/rclone.config}";
        remote = "storage-cache:Plex";
        mountPath = "/mnt/media";
      };
    };
  };
}
