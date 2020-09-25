#! /usr/bin/env bash

echo "Creating home config directory..."
mkdir -p ~/.config/nixpkgs
echo ""

echo "Linking home config files..."
ln -vsf "$(readlink -f ./home/*)" ~/.config/nixpkgs/
echo ""
