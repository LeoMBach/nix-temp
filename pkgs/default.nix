{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./screen.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];

  programs.vim.defaultEditor = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      llh = "ls -lh";
      llha = "ls -lha";

      grep = "grep --color";

      dir = "ls -l";
      cls = "clear";
    };

    systemPackages = with pkgs; [
      aria2
      coreutils
      cron
      cryptsetup
      curl
      file
      fzf
      git
      home-manager
      htop
      input-utils
      less
      lsof
      mkpasswd
      nmap
      p7zip
      pciutils
      pigz
      pixz
      python39
      ripgrep
      rsync
      sshfs
      transcrypt
      tree
      unrar
      unzip
      usbutils
      wget
      zip
    ];
  };
}
