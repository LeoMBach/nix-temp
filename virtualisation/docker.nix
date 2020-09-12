{ config, ... }:

{
    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };
    users.extraGroups.docker.members = [ "leo" ];
  }
