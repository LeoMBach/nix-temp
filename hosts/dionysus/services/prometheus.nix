{ config, lib, ... }:

{
  services.prometheus = {
    enable = true;
    port = 9090;
  };
}