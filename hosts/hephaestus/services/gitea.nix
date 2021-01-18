{ config, lib, ... }:

let
  settings = import ../../../secrets/hephaestus/settings.nix;
in
{
  services.gitea = {
    enable = true;
    domain = settings.git.domain;
    rootUrl = "https://${settings.git.domain}:${builtins.toString(settings.git.port)}";
    database = {
      type = "postgres";
      port = "5432";
    };
  };
}
