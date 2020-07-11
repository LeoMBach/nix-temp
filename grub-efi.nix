{ config, pkgs, lib, ... }:

# Common grub config across EFI hosts

{
    boot.loader = {
        grub = {
            enable = true;
            version = 2;
            device = "nodev";
            efiSupport = true;
        };

        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };
    };
}
