{ config, pkgs, lib, ... }:

let
  settings = import ../../secrets/hephaestus/settings.nix;
in
{
  imports = [
    ../../../hardware-configuration.nix

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

  environment.systemPackages = with pkgs; [ figlet transcrypt ];

  networking = {
    hostName = "hephaestus";
    firewall.allowedTCPPorts = [ 80 443 ];
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    # permitRootLogin = "no";
  };

  security = {
    sudo.wheelNeedsPassword = false;
    acme = {
      acceptTerms = true;
      certs."${settings.domain}" = {
        domain = "*.${settings.domain}";
        dnsProvider = "cloudflare";
        credentialsFile = ../../secrets/hephaestus/cloudflare.env;
      };
      email = "${settings.acme.email}";
      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
  };

  programs.zsh.loginShellInit = "figlet Hephaestus";

  users = {
    mutableUsers = true;
    users = {
      leo = {
        uid = 1000;
        shell = pkgs.zsh;
        home = "/home/leo";
        isNormalUser = true;
        initialPassword = "letmein";
        extraGroups = [ "docker" "wheel" ];
        openssh.authorizedKeys.keyFiles = [ ./keys/hermes.pub ];
      };
    };
  };

  system.stateVersion = "20.09";
}
