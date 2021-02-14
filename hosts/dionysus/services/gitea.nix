{ config, lib, ... }:

let
  globalConf = import ../../../secrets/dionysus/global-config.nix;
in
{
  services.gitea = {
    enable = true;

    appName = "Gitea";
    disableRegistration = true;
    useWizard = true;

    domain = globalConf.git.domain;
    rootUrl = "https://${globalConf.git.domain}:${builtins.toString(globalConf.git.port)}";

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
