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
