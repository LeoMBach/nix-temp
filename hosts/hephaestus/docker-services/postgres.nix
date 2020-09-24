{
  docker-containers = {
    postgres = {
      image = "postgres:12-alpine";
      environment = { POSTGRES_PASSWORD = "postgres"; };
      extraDockerOptions = [
        "--label=traefik.enable=true"
        "--label=traefik.http.routers.postgres.rule=Host(``)"
        "--label=traefik.http.routers.postgres.entrypoints=websecure"
        "--label=traefik.http.routers.postgres.tls.certresolver=letsencrypt"

        "--network=traefik_net"
      ];
    };
  };
}
