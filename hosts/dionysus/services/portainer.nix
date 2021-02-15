{ config, ... }:

{
  virtualisation.oci-containers.containers.portainer = {
    image = "portainer/portainer-ce:2.1.1-alpine";
    ports = [ "9000:9000" ];
    volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
  };
}
