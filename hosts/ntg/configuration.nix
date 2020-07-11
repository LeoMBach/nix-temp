{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./grub-efi.nix
        ./pkgs/common.nix
    ];
}
