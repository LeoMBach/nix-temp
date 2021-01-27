{
  docker-containers = {
    portainer = {
      image = "portainer/portainer-ce:2.0.0-alpine";
      volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
      extraDockerOptions = [
        "--label=traefik.enable=true"
        "--label=traefik.http.routers.portainer.rule=Host(``)"
        "--label=traefik.http.routers.portainer.entrypoints=websecure"
        "--label=traefik.http.routers.portainer.tls.certresolver=letsencrypt"

        "--network=traefik_net"
      ];
    };
  };
}
