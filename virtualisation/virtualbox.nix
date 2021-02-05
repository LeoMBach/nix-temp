{ config, ... }:

# VirtualBox takes a long time to compile and is not always compatible/necessary on certain hosts.
# So, it has it's own little nix file.

{
  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
  users.extraGroups.vboxusers.members = [ "leo" ];
}
