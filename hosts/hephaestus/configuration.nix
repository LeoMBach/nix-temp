{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../hardware-configuration.nix

    ./rclone-mounts.nix
    ./services
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
    figlet
    transcrypt
  ];

  networking.hostName = "hephaestus";

  systemd.services = {
    docker-services-all = {
      description = "Handles all arion-managed docker services.";
      serviceConfig = {
        Type = "simple";
        ExecStart = [''
          /run/current-system/sw/bin/arion \
            --pkgs ./services/arion-pkgs.nix \
            --file ./services/portainer/arion-compose.nix \
            up
        ''];
        ExecStop = [''
          /run/current-system/sw/bin/arion \
            --pkgs ./services/arion-pkgs.nix \
            --file ./services/portainer/arion-compose.nix \
            down
        ''];
        Restart = "always";
        RestartSec = "10";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
    };
  };

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
