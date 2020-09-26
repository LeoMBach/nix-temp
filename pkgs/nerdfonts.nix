{ config, pkgs, ... }:

# Versions < 20.09 don't have the 'fonts' option to selectively install fonts.
# Without this, the entire nerdfont tarball needs to be downloaded every time.

let
  pkgsNext = import <nixos-20.09> {};
in
{
  #nixpkgs.config = {
  #  packageOverrides= pkgs: { nerdfonts = pkgsNext.nerdfonts; };
  #};

  fonts.fonts = with pkgsNext; [
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
