{ config, lib, pkgs, ... }:

{
    imports = [
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
        curl
        file
        fzf
        git
        htop
        input-utils
        less
        mkpasswd
        nmap
        p7zip
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

        # Encryption
        cryptsetup
        gnupg

        # Fonts
        hack-font
        source-code-pro

        home-manager
    ];
  };
}
