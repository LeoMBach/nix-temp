{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.docker-compose ];
  virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
  };
  users.extraGroups.docker.members = [ "leo" ];
}
