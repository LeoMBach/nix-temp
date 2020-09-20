{ config, ... }:

{
  systemd.services.init-docker-networks = {
    description = "Create Hephaestus docker networks.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";

    # TODO: Create multiple networks
    # TODO: Ignore already-existing networks
    script = let docker = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      ${docker} network create traefik_net
    '';
  };
}
