{
  virtualisation.oci-containers.containers = {
    heimdall = {
      image = "linuxserver/heimdall:2.2.2-ls101";
      volumes = [ "/opt/hephaestus/heimdall:/config" ];
      environment = {
        PUID = "1000";
        GUID = "1000";
      };
      extraDockerOptions = [
        "--label=traefik.enable=true"
        "--label=traefik.http.routers.dashboard.rule=Host(``)"
        "--label=traefik.http.routers.dashboard.entrypoints=websecure"
        "--label=traefik.http.routers.dashboard.tls.certresolver=letsencrypt"

        "--network=traefik_net"
      ];
    };
  };
}
