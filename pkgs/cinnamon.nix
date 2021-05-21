{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "cinnamon";
    desktopManager.cinnamon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gettext # Needed for installing applets
    gnome3.gnome-system-monitor
  ];
}
