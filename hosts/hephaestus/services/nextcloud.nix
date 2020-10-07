{
  docker-containers = {
    nextcloud = {
      image = "nextcloud:19-apache";
      volumes = [ "/opt/hephaestus/nextcloud:/var/www/html" ];
      dependsOn = [ "postgres" ];
      environment = {
        NEXTCLOUD_ADMIN_USER = "admin";
        NEXTCLOUD_ADMIN_PASSWORD = "password";
        POSTGRES_DB = "postgres";
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_HOST = "postgres";
      };
      extraDockerOptions = [
        "--label=traefik.enable=true"
        "--label=traefik.http.routers.nextcloud.rule=Host(``)"
        "--label=traefik.http.routers.nextcloud.entrypoints=websecure"
        "--label=traefik.http.routers.nextcloud.tls.certresolver=letsencrypt"

        "--network=traefik_net"
        "--network=nextcloud_net"
      ];
    };
  };
}
