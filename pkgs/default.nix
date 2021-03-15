{ config, lib, pkgs, ... }:

{
  imports = [ ./fonts.nix ./screen.nix ./tmux.nix ./vim.nix ./zsh.nix ];

  programs.vim.defaultEditor = true;

  environment = {
    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      llha = "ls -lha";

      grep = "grep --color";

      dir = "ls -l";
      cls = "clear";
    };

    systemPackages = with pkgs; [
      aria2
      bind
      coreutils
      cron
      cryptsetup
      curl
      direnv
      file
      fzf
      git
      home-manager
      htop
      input-utils
      less
      lsof
      mkpasswd
      nethogs
      nixfmt
      nmap
      nwipe
      p7zip
      pciutils
      pigz
      pixz
      pv
      python38
      ripgrep
      rsync
      smartmontools
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
