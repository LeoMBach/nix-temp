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
      name = "gitea";
      user = "gitea";
      type = "postgres";
      port = "5432";
      createDatabase = false;
    };

    dump = {
      enable = true;
      interval = "02:00";
    };
  };
}
