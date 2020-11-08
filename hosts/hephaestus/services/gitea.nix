{ config, lib, ... }:

{
  services.gitea = {
    enable = true;
    domain = "git.lmgtb.dev";
    rootUrl = "https://git.lmgtb.dev:3000";
    database = {
      type = "postgres";
      port = "5432";
    };
  };
}
