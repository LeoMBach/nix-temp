{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd = {
    availableKernelModules = [
      "ahci"
      "sd_mod"
      "sr_mod"
      "virtio_pci"
      "xhci_pci"
    ];
    kernelModules = [ "nvme" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
  };

  swapDevices = [{
    device = "/swap";
    size = 2048;
  }];
}
