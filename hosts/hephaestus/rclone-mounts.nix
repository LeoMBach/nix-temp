{
  imports = [ ../../modules/rclone-mount.nix ];

  services = {
    rclone-mount.mounts = {
      anime = {
        configPath = "../../secrets/hephaestus/rclone.config";
        remote = "storage-cache:Plex/Anime";
        mountPath = "/mnt/anime";
      };

      doc-movies = {
        configPath = "../../secrets/hephaestus/rclone.config";
        remote = "storage-cache:Plex/Documentary_Movies";
        mountPath = "/mnt/doc-movies";
      };

      doc-tv = {
        configPath = "../../secrets/hephaestus/rclone.config";
        remote = "storage-cache:Plex/Documentary_Shows";
        mountPath = "/mnt/doc-tv";
      };

      movies = {
        configPath = "../../secrets/hephaestus/rclone.config";
        remote = "storage-cache:Plex/Movies";
        mountPath = "/mnt/movies";
      };

      stand-up = {
        configPath = "../../secrets/hephaestus/rclone.config";
        remote = "storage-cache:Plex/Stand-Up";
        mountPath = "/mnt/stand-up";
      };

      tv = {
        configPath = "../../secrets/hephaestus/rclone.config";
        remote = "storage-cache:Plex/TV_Shows";
        mountPath = "/mnt/tv";
      };
    };
  };
}
