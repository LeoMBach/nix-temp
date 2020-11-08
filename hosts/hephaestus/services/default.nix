{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker-network-init.nix
    ./gitea.nix
  ];

  services = {
    fail2ban = {
      enable = true;
      bantime-increment.maxtime = "48h";
    };

    jellyfin.enable = true;
  };
}
