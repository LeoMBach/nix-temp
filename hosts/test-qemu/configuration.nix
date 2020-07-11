{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot = {
        loader = {
            grub = {
                enable = true;
                version = 2;
                device = "nodev";
                efiSupport = true;
            };

            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot/efi";
            };
        };
    };
}
