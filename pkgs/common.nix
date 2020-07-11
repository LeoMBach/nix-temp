{ config, lib, pkgs, ... }:

{
    imports = [
        ./screen.nix
        ./tmux.nix
        ./vim.nix
    ];

    environment.systemPackages = with pkgs; [
        # Basic tools
        aria2
        bash-completion
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
}
