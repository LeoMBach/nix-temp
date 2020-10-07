{
  services.traefik = {
    nixos.useSystemd = true;

    service = {
      image = "traefik:v2.3";
      restart = "always";
      ports = [
        "80:80"
        "443:443"
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock:ro"
        "/opt/hephaestus/traefik/config:/config:ro"
        "/opt/hephaestus/traefik/acme.json:/acme.json"
        "/opt/hephaestus/traefik/traefik.yml:/etc/traefik/traefik.yml:ro"
      ];
      environment = {
        CF_API_EMAIL = "";
        CF_API_KEY = "";
      };
      networks = [ "traefik_net" ];
    };
  };
}
