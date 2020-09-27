{ config, pkgs, lib, ... }:

{
  imports = [
    #../../../hardware-configuration.nix
    ../../common/grub-efi.nix
    ../../nix
    ../../pkgs
    ../../virtualisation/docker.nix
    ./docker-networks.nix
    ./docker-services
    ../../modules/rclone-mount.nix
  ];

  services = {
    traefik = {
      enable = true;
      group = "docker";
      dataDir = "/opt/hephaestus/traefik";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  users.users = {
    hephaestus = {
      uid = 1000;
      shell = pkgs.bash;
      home = "/home/hephaestus";
      isNormalUser = true;
      initialPassword = "letmein";
      extraGroups = [ "docker" "wheel" ];
    };
  };
}
