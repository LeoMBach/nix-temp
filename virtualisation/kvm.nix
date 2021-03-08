{ config, lib, pkgs, ... }:

{
  users.extraGroups.kvm.members = [ "leo" ];
  environment.systemPackages = with pkgs; [
    bridge-utils
    libvirt
    qemu
    qemu_kvm
    spice-vdagent
    virt-manager
  ];
}
