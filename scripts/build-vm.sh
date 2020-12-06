#! /usr/bin/env bash

CONFIG=$1
VM_DISK_NAME=${2:-'nixos.qcow2'}
VM_DISK_SIZE=${3:-'20G'}

export NIX_DISK_IMAGE
NIX_DISK_IMAGE="$(readlink -f "$VM_DISK_NAME")"

if [[ ! -f $VM_DISK_NAME ]]; then
    qemu-img create -f qcow2 "$VM_DISK_NAME" "$VM_DISK_SIZE"
fi

nix-build '<nixpkgs/nixos>' -A vm -I nixos-config="$CONFIG"
