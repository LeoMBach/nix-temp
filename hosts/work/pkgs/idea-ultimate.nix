{ config, ... }:

let
  pkgs = import (builtins.fetchGit {
    name = "idea-ultimate-2020.3";
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "046f8835dcb9082beb75bb471c28c832e1b067b6";
  }) { config.allowUnfree = true; };

  intellij = pkgs.jetbrains.idea-ultimate;
in
{
  environment.systemPackages = [ intellij ];
}
