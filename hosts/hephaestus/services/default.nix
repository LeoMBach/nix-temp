{ config, lib, pkgs, ... }:

{
  imports = [
    ./borg.nix
    ./gitea.nix
    ./nextcloud.nix
    ./nginx.nix
    ./postgresql.nix
  ];

  services = {
    fail2ban = {
      enable = true;
        enable = true;
        maxtime = "72h";
      };
    };

    jellyfin.enable = true;
  };
}
