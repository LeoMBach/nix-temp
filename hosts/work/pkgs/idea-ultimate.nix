{ config, ... }:

let
   pkgs = import (builtins.fetchGit {
       name = "idea-ultimate-2019.3";
       url = "https://github.com/nixos/nixpkgs-channels/";
       ref = "refs/heads/nixpkgs-unstable";
       rev = "fcc8660d359d2c582b0b148739a72cec476cfef5";
   }) { config.allowUnfree = true; };

   intellij = pkgs.jetbrains.idea-ultimate;
in
{
  environment.systemPackages = [ intellij ];
}
