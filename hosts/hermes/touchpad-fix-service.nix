{ config, lib, pkgs, ... }:

# Hacky workaround to re-enable the touchpad on demand.
# Currently, the touchpad disables itself upon resume.

# TODO: Find a way to invoke this upon xorg start

{
  systemd.user.services.touchpad-fix = {
    description = "Re-enable touchpad";
    serviceConfig.Type = "oneshot";

    path = [ pkgs.xorg.xinput ];
    script = ''
      touchpad="$(xinput | grep Touchpad | cut -d ' ' -f 5,6,7)"
      echo "$touchpad"
      xinput --enable "$touchpad"
    '';
  };
}
