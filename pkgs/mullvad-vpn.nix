{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mullvad-vpn ];

  # Can be removed on merge of: https://github.com/NixOS/nixpkgs/pull/121906
  networking.firewall.checkReversePath = "loose";

  networking.wireguard.enable = true;
  services.mullvad-vpn.enable = true;
}
