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

  users = {
    mutableUsers = true;
    users = {
      hephaestus = {
        uid = 1000;
        shell = pkgs.zsh;
        home = "/home/hephaestus";
        isNormalUser = true;
        initialPassword = "letmein";
        extraGroups = [ "docker" "wheel" ];
      };
    };
  };
}
