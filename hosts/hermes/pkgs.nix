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
    brave
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
    google-chrome
    handbrake
    hcloud
    lazygit
    libguestfs
    libreoffice
    lutris
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
    steam
    syncthing-tray
    unstable.cryptomator
    unstable.foxitreader
    unstable.joplin-desktop
    unstable.restic
    vlc
    vscode
    wireshark
    yarn
    youtube-dl
    zoom-us
  ];
}
