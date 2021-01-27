{ config, lib, ... }:

let
  settings = import ../../../secrets/dionysus/settings.nix;
in
{
  services.dokuwiki.personal = {
    enable = true;

    acl = ''
      *  @ALL  1
    '';

    extraConfig = ''
      $conf['disableactions'] = 'register';
    '';

    nginx.listen = [
      {
        addr = "127.0.0.1";
        port = settings.wiki.port;
      }
    ];

    usersFile = "/etc/nixos/nixos-config/secrets/dionysus/dokuwiki/users.auth.php";
  };
}
