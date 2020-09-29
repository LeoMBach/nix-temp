{
  docker-containers = {
    traefik = {
      image = "traefik:v2.3";
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock:ro"
        "/opt/hephaestus/traefik/config:/config:ro"
        "/opt/hephaestus/traefik/acme.json:/acme.json"
        "/opt/hephaestus/traefik/traefik.yml:/etc/traefik/traefik.yml:ro"
      ];
      extraDockerOptions = [
        "traefik.enable=true"
        "traefik.http.routers.api.rule=Host(``)"
        "traefik.http.routers.api.entrypoints=websecure"
        "traefik.http.routers.api.service=api@internal"
        # DNS Challenge
        "traefik.http.routers.api.tls.certresolver=letsencrypt"
        "traefik.http.routers.api.tls.domains[0].main="
        "traefik.http.routers.api.tls.domains[0].sans=*."
        # HTTP -> HTTPS redirect
        "traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https"
        "traefik.http.routers.redirect-https.rule=hostregexp(`{host:.+}`)"
        "traefik.http.routers.redirect-https.entrypoints=web"
        "traefik.http.routers.redirect-https.middlewares=redirect-to-https"
        "traefik.http.routers.api.middlewares=chain-oauth@file"
      ];
    };
  };
}
