{
  services.tlp = {
    enable = true;
    extraConfig = ''
      TLP_DEFAULT_MODE=BAT
      CPU_SCALING_GOVERNOR_ON_AC=ondemand
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
    '';
  };
}
