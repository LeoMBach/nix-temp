{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../hardware-configuration.nix

    ./docker-network-init.nix
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

  environment.systemPackages = [
    (import (builtins.fetchTarball https://github.com/hercules-ci/arion/tarball/master) {}).arion
  ];

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

  system.stateVersion = "20.09";
}
