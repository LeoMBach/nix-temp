{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ dive docker-compose ];
  virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
  };
  users.extraGroups.docker.members = [ "leo" ];
}
