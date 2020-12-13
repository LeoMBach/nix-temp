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
      bantime-increment.maxtime = "48h";
    };

    jellyfin.enable = true;
  };
}
