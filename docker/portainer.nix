{ config, lib, ... }:

{
    docker-containers = {
        portainer = {
            image = "portainer/portainer:1.23.2";
            ports = [ "9000:9000" ];
            volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
            extraDockerOptions = [
                "--network=traefik_net"
            ];
        };
    };

    systemd.services = {
        init-docker-networks = {
            description = "Create necessary docker networks.";
            after = [ "network.target" ];
            wantedBy = [ "multi-user.target" ];

            serviceConfig.Type = "oneshot";

            script = let dockercli = "${config.virtualisation.docker.package}/bin/docker";
                in ''
                    traefikNet=$(${dockercli} network ls | grep "traefik_net" || true)
                    if [ -z "$traefikNet" ]; then
                        ${dockercli} network create traefik_net
                    else
                        echo "traefik_net already exists"
                    fi
                '';
        };
    };
}
