{ config, lib, pkgs, ... }:

{
  imports = [
    ./borg.nix
    ./dokuwiki.nix
    ./gitea.nix
    ./heimdall.nix
    ./nextcloud.nix
    ./nginx.nix
    ./portainer.nix
    ./postgresql.nix
    ./rclone.nix
    ./syncthing.nix
  ];

  services = {
    fail2ban = {
      enable = true;
      bantime-increment = {
        enable = true;
        maxtime = "72h";
      };
    };

    jellyfin.enable = true;
  };
}
