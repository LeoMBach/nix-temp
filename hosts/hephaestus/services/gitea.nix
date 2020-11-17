{ config, lib, ... }:

let
  settings = import ../../../secrets/hephaestus/settings.nix;
in
{
  services.gitea = {
    enable = true;
    domain = settings.gitDomain;
    rootUrl = "https://${settings.gitDomain}:3000";
    database = {
      type = "postgres";
      port = "5432";
    };
  };
}
