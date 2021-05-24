{ config, pkgs, lib, ... }:

let
  globalConf = import ../../secrets/dionysus/global-config.nix;
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

  environment.systemPackages = with pkgs; [ figlet transcrypt ];

  networking = {
    hostName = "dionysus";
    firewall.allowedTCPPorts = [ 80 443 ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    acme = {
      acceptTerms = true;
      certs."${globalConf.domain}" = {
        domain = "*.${globalConf.domain}";
        dnsProvider = "cloudflare";
        credentialsFile = ../../secrets/dionysus/cloudflare.env;
      };
      email = "${globalConf.acme.email}";
      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
  };

  programs.zsh.loginShellInit = "figlet Dionysus";

  users.users = {
    leo = {
      uid = 1000;
      shell = pkgs.zsh;
      home = "/home/leo";
      isNormalUser = true;
      passwordFile = "${../../secrets/dionysus/leo.pass}";
      extraGroups = [ "docker" "syncthing" "wheel" ];
      openssh.authorizedKeys.keyFiles = [ ./keys/hermes.pub ];
    };
  };

  system.stateVersion = "20.09";
}
