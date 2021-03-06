{ config, pkgs, ... }:

{
  # Required to run X11 under Hyper-V
  services.xserver = {
    modules = [ pkgs.xorg.xf86videofbdev ];
    videoDrivers = [ "hyperv_fb" ];
  };

  virtualisation.hypervGuest = {
    enable = true;
    videoMode = "1280x720";
  };
}
