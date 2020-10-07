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

    figlet
    rclone
    transcrypt
  ];

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.loginShellInit = "figlet Hephaestus";

  users = {
    mutableUsers = true;
    users = {
      heph = {
        uid = 1000;
        shell = pkgs.zsh;
        home = "/home/heph";
        isNormalUser = true;
        initialPassword = "letmein";
        extraGroups = [ "docker" "wheel" ];
        openssh.authorizedKeys.keyFiles = [ ./keys/hermes.pub ];
      };
    };
  };

  system.stateVersion = "20.09";
}
