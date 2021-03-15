{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../hardware-configuration.nix

    ./pkgs/idea-ultimate.nix

    ../../common/grub-efi.nix
    ../../common/laptop.nix
    ../../common/ssd.nix
    ../../common/user.nix
    ../../nix
    ../../pkgs
    ../../pkgs/plasma5.nix
    ../../virtualisation/docker.nix
    ../../modules/vscode-liveshare.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_5_10;
    kernelParams = [
      "i915.enable_fbc=1" # https://wiki.archlinux.org/index.php/intel_graphics#Framebuffer_compression_(enable_fbc)
      "intel_pstate=disable"
    ];
    kernelModules = [
      "kvm-amd"
      "kvm-intel"
    ];

    loader.grub.enableCryptodisk = true;

    initrd = {
      luks.devices = {
        ssd = {
          device = "/dev/disk/by-label/cryptlvm";
          preLVM = true;
          allowDiscards = true;
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
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;

    opengl.extraPackages = [ pkgs.vaapiIntel ];

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };
  };

  networking = {
    hostName = "ZAGALW-LMA-HP";
    networkmanager.enable = true;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp2s0.useDHCP = true;
    };

    # Needed for Expo & Metro bundler
    firewall.allowedTCPPorts = [
      19000
      19001
      37446
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Europe/Zagreb";

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    acpi
    acpid
    android-studio
    ansible
    ansible-lint
    ant
    birdtray
    brave
    chromium
    cloudfoundry-cli
    dbeaver
    dive
    dropbox
    eclipses.eclipse-java
    f3
    firefox
    freerdp
    fuse3
    fzf
    gimp
    gitAndTools.gitflow
    glib-networking # Needed by Eclipse Liberty Tools plugin
    gradle
    home-manager
    inkscape
    jd-gui
    jdk14
    lazygit
    libreoffice
    liquibase
    lm_sensors
    maven
    meld
    networkmanager-openconnect
    nodePackages.npm
    nodejs
    openconnect
    oraclejdk8
    poetry
    postman
    qemu
    rclone
    remmina
    s-tui
    scrcpy
    shellcheck
    signal-desktop
    skype
    soapui
    speedtest-cli
    sshfs
    sshuttle
    teams
    thunderbird
    virt-manager
    vlc
    vscode
    wireshark
    yarn
    youtube-dl
  ];

  systemd.timers.borgbackup-job-work.timerConfig.Persistent = true;

  services = {
    borgbackup.jobs.work = {
      paths = "/home/leo/Code/work";
      repo = "/mnt/hdd/.borg/work";
      user = "leo";

      encryption.mode = "repokey-blake2";
      encryption.passCommand = "cat /etc/nixos/nixos-config/secrets/work/borg/work-pass";

      compression = "auto,zstd,19";
      startAt = "daily";
      prune.keep = {
        within = "1d";
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 1;
      };

      exclude = [
        "*.class"
        "__pycache__/*"
        "node_modules/*"
      ];
    };

    davmail = {
      enable = true;
      url = "https://owa.versoaltima.com/EWS/Exchange.asmx";
      config.davmail = {
        popPort = 1110;
        imapPort = 1143;
        smtpPort = 1025;
        caldavPort = 1080;
        ldapPort = 1389;
        keepDelay = 30;
        sentKeepDelay = 90;
      };
    };
    xserver = {
      displayManager = {
        autoLogin.user = "leo";
        defaultSession = "plasma5";
      };
      videoDrivers = [ "intel" ];
    };
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
    };

    java = {
      enable = true;
      package = pkgs.jdk14;
    };

    ssh = {
      startAgent = true;
      extraConfig = builtins.readFile ../../secrets/work/ssh/config;
    };

    usbtop.enable = true;
  };

  system.stateVersion = "20.09";
}
