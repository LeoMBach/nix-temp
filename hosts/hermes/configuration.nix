{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../hardware-configuration.nix

    ../../common/amdgpu.nix
    ../../common/grub-efi.nix
    ../../common/user.nix
    ../../common/laptop.nix
    ../../nix
    ../../pkgs
    ../../pkgs/plasma5.nix
    ../../virtualisation/docker.nix
    ../../modules/vscode-liveshare.nix

    ./pkgs.nix
    ./touchpad-fix-service.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_5_10;
    kernelModules = [
      "acpi-call"
      "amdgpu"
      "kvm-amd"
    ];
    blacklistedKernelModules = [ "sp5100_tco" ];

    # Fixes backlight save/load systemd service
    kernelParams = [
      "acpi_backlight=native"
      "acpi_enforce_resources=lax"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];

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
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "hermes";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
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
    avahi.enable = true;

    # Suspend to ram doesn't work on the Yoga Slim 7 without some finangling.
    # This is a simple workaround.
    logind.lidSwitch = "lock";

    openssh.enable = true;

    syncthing = {
      enable = true;
      group = "users";
      declarative = {
        cert = "${../../../nixos-config/secrets/hermes/syncthing/cert.pem}";
        key = "${../../../nixos-config/secrets/hermes/syncthing/key.pem}";

        devices = {
          circe = {
            name = "circe";
            id = "T2SX6WE-VSTHGT6-JUEZNX5-N5ADWQH-MD74SL7-4IVBFPJ-DYQD3KJ-EI66FQZ";
          };
          work = {
            name = "work";
            id = "6ICA2O5-FF27QPK-VWUI35V-BLTFWWT-POJBADG-X44RVFZ-EOIMQWT-SVT2KQR";
          };
        };
      };
    };

    xserver = {
      enable = true;
      displayManager = {
        autoLogin.user = "leo";
        defaultSession = "plasma5";
      };
      videoDrivers = [ "amdgpu" ];
    };
  };

  # Disable the sap plugin, just to get rid of two lines of error text on each bluetoothd restart.
  # First entry is a blank string, otherwise systemd complains of multiple ExecStart entries.
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "/run/current-system/sw/bin/bluetoothd --noplugin=sap"
  ];

  programs = {
    adb.enable = true;
    dconf.enable = true;
    java.enable = true;
    usbtop.enable = true;

    gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
    };

    ssh = {
      startAgent = true;
      extraConfig = builtins.readFile ../../secrets/hermes/ssh-config;
    };
  };

  virtualisation.libvirtd.enable = true;

  system.stateVersion = "20.03";
}
