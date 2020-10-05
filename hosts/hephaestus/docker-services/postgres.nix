{
  docker-containers = {
    postgres = {
      image = "postgres:12-alpine";
      environment = { POSTGRES_PASSWORD = "postgres"; };
      extraOptions = [
        "--network=nextcloud_net"
        "--network=borg_net"
      ];
    };
  };
}
