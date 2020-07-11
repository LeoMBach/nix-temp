{ config, lib, pkgs, ...}:

# VirtualBox takes a long time to compile and is not always compatible/necessary on certain hosts.
# So, it has it's own little nix file.

{
    environment.systemPackages = with pkgs; [
        virtualbox
        virtualboxWithExtpack
    ];
}
