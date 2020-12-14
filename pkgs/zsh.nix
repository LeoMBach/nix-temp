{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh-powerlevel10k
    gitAndTools.gitstatus
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    # zsh-powerlevel10k is a system package, so it's sourced instead of used in "ohMyZsh.theme"
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    interactiveShellInit = ''

      eval "$(direnv hook zsh)"

      shell-nix-init() {
        echo 'Creating shell.nix'
        echo '{ pkgs ? import <nixpkgs> {} }:' >> shell.nix
        echo "" >> shell.nix
        echo 'pkgs.mkShell {' >> shell.nix
        echo '  buildInputs = [];' >> shell.nix
        echo '}' >> shell.nix

        echo 'Creating .envrc'
        echo 'use_nix' >> .envrc

        direnv allow
      }
    '';

    ohMyZsh = {
      enable = true;
      plugins = [
        "adb"
        "docker"
        "docker-compose"
        "gitignore"
        "ripgrep"
        "yarn"
      ];
    };
  };
}
