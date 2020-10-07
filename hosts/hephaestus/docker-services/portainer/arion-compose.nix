{
  services.portainer = {
    nixos.useSystemd = true;

    service = {
      image = "portainer/portainer-ce:2.0.0-alpine";
      restart = "always";
      volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
      networks = [ "traefik_net" ];
    };
  };
}
