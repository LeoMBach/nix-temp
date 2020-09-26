{ config, lib, pkgs, ... }:

{
  imports = [
    ./nerdfonts.nix
    ./screen.nix
    ./tmux.nix
    ./vim.nix
  ];

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
      # Basic tools
      aria2
      coreutils
      cron
      cryptsetup
      curl
      file
      fzf
      git
      htop
      input-utils
      less
      lsof
      mkpasswd
      nethogs
      nmap
      p7zip
      pciutils
      pigz
      pixz
      python38
      ripgrep
      rsync
      sshfs
      tree
      unzip
      usbutils
      wget
      zip

      home-manager
    ];
  };
}
