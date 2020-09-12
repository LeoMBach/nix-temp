{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./grub-efi.nix
        ./user.nix
        ./pkgs/common.nix
        ./pkgs/plasma5.nix
        ./pkgs/virtualbox.nix
    ];

    boot = {
        kernelPackages = pkgs.linuxPackages_5_7;

        kernelModules = [ "acpi_call" ];
        extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

        # Fixes backlight save/load systemd service
        kernelParams = [ "acpi_backlight=native" ];

        loader.grub.enableCryptodisk = true;

        initrd = {
            luks.devices = {
                cryptlvm = {
                    device = "/dev/disk/by-label/cryptlvm";
                    preLVM = true;
                    allowDiscards = true;
                };
            };

            availableKernelModules = [
                "aes_x86_64"
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
        hostName = "hermes";
        networkmanager.enable = true;
        interfaces.wlp1s0.useDHCP = true;
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
        tlp.enable = true;

        # Suspend to ram doesn't work on the Yoga Slim 7 without some finangling.
        # This is a simple workaround.
        logind.lidSwitch = "lock";
    };

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        ansible
        ansible-lint
        bitwarden
        chromium
        dbeaver
        dive
        dropbox
        ffmpeg
        firefox
        freerdp
        fuse3
        handbrake
        joplin-desktop
        lazygit
        mediainfo
        nodePackages.npm
        nodejs-13_x
        poetry
        postman
        qemu
        rclone
        remmina
        scrcpy
        shellcheck
        signal-desktop
        sshfs
        vlc
        vscode
        wireshark
        yarn
        youtube-dl
    ];

    programs = {
        adb.enable = true;
        java.enable = true;
        usbtop.enable = true;

        gnupg.agent = {
          enable = true;
          pinentryFlavor = "curses";
        };

        ssh = {
          startAgent = true;
          extraConfig = ''
            Host router
              HostName gl-ar750s
              User root
          '';
        };
    };

    fonts.fonts = with pkgs; [
        hack-font
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        source-code-pro
    ];

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };

    system.stateVersion = "20.03";
}
