{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker-network-init.nix
  ];
  services = {
    fail2ban = {
      enable = true;
      bantime-increment.maxtime = "48h";
    };
  };
}
