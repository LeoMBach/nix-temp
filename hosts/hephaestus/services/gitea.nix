{ config, lib, ... }:

let
  settings = import ../../../secrets/hephaestus/settings.nix;
in
{
  services.gitea = {
    enable = true;

    appName = "Gitea";
    disableRegistration = true;
    useWizard = true;

    domain = settings.git.domain;
    rootUrl = "https://${settings.git.domain}:${builtins.toString(settings.git.port)}";

    cookieSecure = true;

    database = {
      type = "postgres";
      port = "5432";
    };
  };
}
