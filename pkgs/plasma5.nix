{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; with plasma5; with kdeApplications; [
    ark
    dragon
    gwenview
    kate
    kcalc
    kdeconnect
    ksystemlog
    ktorrent
    okular
    partition-manager
  ];
}
