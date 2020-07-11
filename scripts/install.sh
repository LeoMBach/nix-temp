#! /usr/bin/env bash

VALID_TARGETS=$(ls ./hosts)

if [[ $EUID -gt 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

target=$1
if [[ ! $target || ! "${VALID_TARGETS[*]}" =~ $target ]]; then
    echo "'$target' is not a valid target."
    echo "Valid targets:"
    echo "${VALID_TARGETS[*]}"
    exit 1
fi

if [[ ! -d /mnt ]]; then
    echo "/mnt not found. Exiting.."
    exit 1
fi

echo "Generating NixOS default configuration..."
nixos-generate-config --root /mnt
echo ""

echo "Linking system nix files..."
ln -vf "$(pwd)"/hosts/"$target"/configuration.nix /mnt/etc/nixos/
ln -vf "$(pwd)"/user.nix /mnt/etc/nixos/
ln -vf "$(pwd)"/grub-efi.nix /mnt/etc/nixos/
ln -vf "$(pwd)"/secrets/user.password /mnt/etc/nixos
mkdir /mnt/etc/nixos/pkgs
ln -vf pkgs/* ../pkgs
echo ""

echo "Starting NixOS installation..."
nixos-install
