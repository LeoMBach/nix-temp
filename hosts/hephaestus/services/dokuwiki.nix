{ config, lib, ... }:

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
        port = 4444;
      }
    ];

    usersFile = "/etc/nixos/nixos-config/secrets/hephaestus/dokuwiki/users.auth.php";
  };
}
