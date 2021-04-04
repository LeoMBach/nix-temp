{ config, lib, pkgs, ... }:

# Hacky workaround to re-enable the touchpad on demand.
# Currently, the touchpad disables itself upon resume.

# TODO: Find a way to invoke this upon xorg start

{
  systemd.services.touchpad-fix = {
    description = "Re-enable touchpad";
    serviceConfig.Type = "oneshot";

    environment = {
      DISPLAY = ":0";
      XAUTHORITY = "/home/leo/.Xauthority";
    };

    path = [ pkgs.xorg.xinput ];
    script = ''
      echo "Waiting 5 seconds..."
      sleep 5
      touchpad="$(xinput | grep Touchpad | cut -d ' ' -f 5,6,7)"
      echo "Found touchpad: $touchpad"
      echo "Re-enabling touchpad..."
      xinput --enable "$touchpad"
    '';

    wantedBy = [
      "multi-user.target"
      "sleep.target"
      "suspend.target"
      "hibernate.target"
    ];
    after = [ "sleep.target" "suspend.target" "hibernate.target" ];
  };
}
