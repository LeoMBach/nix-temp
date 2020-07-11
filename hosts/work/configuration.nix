{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./grub-efi.nix
        ./user.nix
        ./pkgs/common.nix
        ./pkgs/plasma5.nix
    ];

    boot = {
        loader.grub.enableCryptodisk = true;
        initrd = {
            luks.devices = {
                ssd = {
                    device = "/dev/disk/by-label/ssd-lvm";
                    preLVM = true;
                    allowDiscards = true;
                };

                hdd = {
                    device = "/dev/disk/by-label/hdd-lvm";
                    keyFile = "/dev/disk/by-label/ssd-lvm/root/hdd.lk";
                };
            };

            # Improve encryption performance
            availableKernelModules = [
                "aes_x86_64"
                "aesni_intel"
                "cryptd"
            ];
        };
    };

    hardware = {
        bluetooth.enable = true;
        pulseaudio = {
                enable = true;
                package = pkgs.pulseaudioFull;
            };
    };

    networking = {
        hostName = "ZAGALW-LMA-HP";
        wireless.enable = true;
        interfaces = {
            enp0s25.useDHCP = true;
            wlp2s0.useDHCP = true;
        };
    };

    i18n.defaultLocale = "en_US.UTF-8";

    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    time.timeZone = "Europe/Zagreb";

    security.sudo.wheelNeedsPassword = false;

    services = {
        openssh.enable = true;

        # borgbackup.jobs = {};
    };

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        android-studio
        chromium
        dbeaver
        dive
        firefox
        freerdp
        fuse3
        jetbrains.idea-ultimate
        lazygit
        postman
        rclone
        remmina
        scrcpy
        signal-desktop
        sshfs
        teams
        vscode
    ];

    programs = {
        adb.enable = true;
        java.enable = true;
        npm.enable = true;
        ssh.startAgent = true;
        usbtop.enable = true;
    };

    fonts.fonts = [
        pkgs.hack-font
        pkgs.source-code-pro
    ];

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };

    system.stateVersion = "20.03";
}
