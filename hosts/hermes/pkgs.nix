{ config, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixos-unstable") {
    config = config.nixpkgs.config;
  };
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    acpi
    ansible
    ansible-lint
    bitwarden
    chromium
    dbeaver
    dive
    dropbox-cli
    etcher
    f3
    ffmpeg
    figlet
    firefox
    freerdp
    fuse3
    handbrake
    hcloud
    lazygit
    libguestfs
    libreoffice
    mediainfo
    ncdu
    nodePackages.node2nix
    nodePackages.npm
    nodejs
    openssl
    postman
    python38Packages.pip
    python38Packages.poetry
    python38Packages.pylint
    python38Packages.wheel
    qdirstat
    rclone
    remmina
    s-tui
    scrcpy
    shellcheck
    signal-desktop
    skype
    sshfs
    syncthing-tray
    unstable.joplin-desktop
    unstable.restic
    vlc
    vscode
    wireshark
    yarn
    youtube-dl
  ];
}
