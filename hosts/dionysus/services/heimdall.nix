{ config, ... }:

{
  virtualisation.oci-containers.containers.heimdall = {
    image = "linuxserver/heimdall:version-2.2.2";
    volumes = [ "/var/lib/heimdall/config:/config" ];
    ports = [ "444:443" ];
    environment = {
      PUID = "1000";
      GUID = "1000";
    };
  };
}
