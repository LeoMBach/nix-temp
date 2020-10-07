{
  services.heimdall = {
    nixos.useSystemd = true;

    service = {
      image = "linuxserver/heimdall:2.2.2-ls101";
      restart = "always";
      volumes = [ "/opt/hephaestus/heimdall:/config" ];
      environment = {
        PUID = "1000";
        GUID = "1000";
      };
      networks = [ "traefik_net" ];
    };
  };
}
