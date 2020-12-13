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
    permitRootLogin = false;
    authorizedKeysFiles = [ ./keys/hermes.pub ];
  };

  security = {
    sudo.wheelNeedsPassword = false;
    acme = {
      acceptTerms = true;
      certs."${settings.domain}" = {
        domain = "${settings.domain}";
        extraDomainNames = [ "*.${settings.domain}" ];
      };
      email = "${settings.acmeEmail}";
      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
  };

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
      };
    };
  };

  system.stateVersion = "20.09";
}
