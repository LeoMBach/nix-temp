{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    corefonts
    (nerdfonts.override { fonts = [ "DroidSansMono" "FiraCode" "Hack" "Meslo" "SourceCodePro" ]; })
  ];
}
