{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "DroidSansMono"
        "FiraCode"
        "Hack"
        "Meslo"
        "SourceCodePro"
      ];
    })
  ];
}
