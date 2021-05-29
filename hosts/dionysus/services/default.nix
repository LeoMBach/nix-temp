{ config, lib, pkgs, ... }:

{
  imports = [
    ./grafana
    ./jellyfin.nix
    # ./nextcloud.nix
    ./postgresql.nix
  ];

  services = {
    fail2ban = {
      enable = true;
      bantime-increment = {
        enable = true;
        maxtime = "72h";
      };
    };

    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
  };
}
