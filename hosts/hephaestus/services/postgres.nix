{
  docker-containers = {
    postgres = {
      image = "postgres:12-alpine";
      environment = { POSTGRES_PASSWORD = "postgres"; };
      extraDockerOptions = [
        "--network=nextcloud_net"
        "--network=borg_net"
      ];
    };
  };
}
