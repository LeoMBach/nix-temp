{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    declarative = {
      cert = "${../../../secrets/dionysus/syncthing/cert.pem}";
      key = "${../../../secrets/dionysus/syncthing/key.pem}";

      devices = {
        hermes = {
          name = "hermes";
          id = "2TZKSIR-WEJ6S36-GCFXZSX-Z6KSCRB-CNQUVOG-XUBEMV6-VEURJV4-DYPWLAU";
        };
        work = {
          name = "work";
          id = "6ICA2O5-FF27QPK-VWUI35V-BLTFWWT-POJBADG-X44RVFZ-EOIMQWT-SVT2KQR";
        };
      };
    };
  };
}
