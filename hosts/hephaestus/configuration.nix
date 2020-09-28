{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../hardware-configuration.nix

    ./docker-networks.nix
    ./docker-services
    ../../modules/rclone-mount.nix
    ../../nix
    ../../pkgs/vim.nix
    ../../pkgs/screen.nix
    ../../pkgs/tmux.nix
    ../../virtualisation/docker.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

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
