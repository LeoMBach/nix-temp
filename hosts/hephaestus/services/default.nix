{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker-network-init.nix
  ];
}
