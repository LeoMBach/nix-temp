{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../hardware-configuration.nix

    ./rclone-mounts.nix
    ../../nix
    ../../pkgs
    ../../virtualisation/docker.nix
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  environment.systemPackages = with pkgs; [
    (import (builtins.fetchTarball https://github.com/hercules-ci/arion/tarball/master) {}).arion

    rclone
    transcrypt
  ];

  services.openssh.enable = true;

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

        openssh = {
          authorizedKeys.keyFiles = [ ./keys/hermes.pub ];
        };
      };
    };
  };

  system.stateVersion = "20.09";
}
