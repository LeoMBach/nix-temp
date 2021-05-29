{ config, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  virtualisation.oci-containers.containers.portainer = {
    image = "portainer/portainer-ce:2.1.1-alpine";
    ports = [ "9000:9000" ];
    volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
  };

  services.nginx.virtualHosts."${globalConf.portainer.domain}" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = { proxyPass = "http://127.0.0.1:${toString globalConf.portainer.port}"; };
  };
}
