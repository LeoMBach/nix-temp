{
  virtualisation.oci-containers.containers = {
    borgmatic = {
      image = "b3vis/borgmatic:v1.1.13-1.5.8";
      volumes = [
        "${./config.yml}:/etc/borgmatic.d/config.yml"
        "${./crontab.txt}:/etc/borgmatic.d/crontab.txt"
        "/opt/hephaestus:/mnt/source:ro"
        "/opt/hephaestus/borg/repo:/mnt/borg-repository"
        "/opt/hephaestus/borg/.borgmatic:/root/.borgmatic"
        "/opt/hephaestus/borg/.config/borg:/root/.config/borg"
        "/opt/hephaestus/borg/.cache/borg:/root/.cache/borg"
        "/opt/hephaestus/borg/.ssh:/root/.ssh"
      ];
      environment = { BORG_PASSPHRASE = "borgmatic"; };
      extraDockerOptions = [
        "--network=borg_net"
      ];
    };
  };
}
