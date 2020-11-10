{ config, lib, pkgs, ... }:

# https://nixos.wiki/wiki/AMD_GPU

{
  boot = {
    blacklistedKernelModules = [ "radeon" ];
    kernelModules = [ "amdgpu" ];
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
