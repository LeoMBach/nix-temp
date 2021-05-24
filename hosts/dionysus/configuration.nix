{ config, pkgs, lib, ... }:

let
  globalConf = import ../../secrets/dionysus/global-config.nix;
  unstable = import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixos-unstable") {
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    ../../nix
    ../../pkgs
    ../../virtualisation/docker.nix

    ./hardware-config.nix
    ./services
  ];

  boot.loader.grub = {
   enable = true;
   version = 2;
   device = "/dev/sda";
  };

  environment.systemPackages = with pkgs; [
    unstable.cloudflared # TODO: Setup as service
    figlet
    transcrypt
  ];

  networking = {
    hostName = "dionysus";
    firewall.allowedTCPPorts = [ 80 443 ];
    firewall.allowPing = false;
  };

  security = {
    sudo.wheelNeedsPassword = false;
    acme = {
      acceptTerms = true;
      email = "${globalConf.acme.email}";
      # server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
  };

  programs.zsh.loginShellInit = "figlet Dionysus";

  users.users = {
    leo = {
      uid = 1000;
      shell = pkgs.zsh;
      home = "/home/leo";
      isNormalUser = true;
      hashedPassword = "$6$3e5n6atu72ozD90q$ko.BxV4plP0.UWQKVVHrknECx1bUGGQtmzZV0hepvtwU2Povv89jM2TPLOjfHbX.Y3BHWWA.MeFtJauHrjWaQ.";
      extraGroups = [ "docker" "syncthing" "wheel" ];
      openssh.authorizedKeys.keyFiles = [ ./keys/hermes.pub ];
    };
  };

  system.stateVersion = "20.09";
}
