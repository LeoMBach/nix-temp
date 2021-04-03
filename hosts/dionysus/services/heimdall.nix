{ config, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
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

  services.nginx.virtualHosts."${globalConf.dashboard.domain}" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = { proxyPass = "http://127.0.0.1:${builtins.toString(globalConf.dashboard.port)}"; };
  };
}
