{ config, ... }:

{
  systemd.services.docker-init-networks = {
    description = "Create Hephaestus docker networks.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";

    script = let
      awk = "/run/current-system/sw/bin/awk";
      docker = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      existing_networks=$(${docker} network ls | ${awk} '{ if (NR>1) { print $2 } }' || echo true)
      networks=("borg_net" "traefik_net")
      for net in "''${networks[@]}"; do
        if [[ "''${existing_networks[*]}" =~ $net ]]; then
          echo "Docker network \"$net\" already exists."
        else
          ${docker} network create $net
        fi
      done
    '';
  };
}
