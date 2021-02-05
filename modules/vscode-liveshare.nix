{
  imports = [ (fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master") ];

  services.vsliveshare = {
    enable = true;
    extensionsDir = "$HOME/.vscode/extensions";
  };
}
