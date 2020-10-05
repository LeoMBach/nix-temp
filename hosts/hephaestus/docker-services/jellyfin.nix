{
  virtualisation.oci-containers.containers = {
    jellyfin = {
      image = "linuxserver/jellyfin:10.6.4-1-ls76";
      volumes = [
        "/path/to/library:/config" # This can get big! 50GB+ for a large collection!
        "/mnt/movies:/data/movies"
        "/mnt/tv:/data/tv"
        "/mnt/anime:/data/anime"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
      };
      extraDockerOptions = [
        "--label=traefik.enable=true"
        "--label=traefik.http.routers.jellyfin.rule=Host(``)"
        "--label=traefik.http.routers.jellyfin.entrypoints=websecure"
        "--label=traefik.http.routers.jellyfin.tls.certresolver=letsencrypt"

        "--network=traefik_net"
      ];
    };
  };
}
