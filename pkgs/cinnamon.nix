{ config, pkgs, lib, ... }:

{
  services = {
    cinnamon.apps.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      displayManager.sddm.enable = true;
      displayManager.defaultSession = "cinnamon";
      desktopManager.cinnamon.enable = true;
    };
  };

  environment = {
    cinnamon.excludePackages = [];
    systemPackages = with pkgs; [
      gettext # Needed for installing applets
      gnome.file-roller
      gnome.gnome-system-monitor
      hardinfo
    ];
  };
}
