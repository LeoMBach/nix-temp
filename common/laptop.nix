{
  services.tlp = {
    enable = true;
    settings = {
      "TLP_DEFAULT_MODE" = "BAT";
      "CPU_SCALING_GOVERNOR_ON_AC" = "ondemand";
      "CPU_SCALING_GOVERNOR_ON_BAT" = "powersave";
      "CPU_ENERGY_PERF_POLICY_ON_AC" = "balance_performance";
      "CPU_ENERGY_PERF_POLICY_ON_BAT" = "balance_power";
    };
  };
}
