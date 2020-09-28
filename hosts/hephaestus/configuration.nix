{ config, pkgs, lib, ... }:

{
  imports = [
    #../../../hardware-configuration.nix

    ./docker-networks.nix
    ./docker-services
    ../../common/grub-efi.nix
    ../../modules/rclone-mount.nix
    ../../nix
    ../../pkgs/vim.nix
    ../../pkgs/screen.nix
    ../../pkgs/tmux.nix
    ../../virtualisation/docker.nix
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
