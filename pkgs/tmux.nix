{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    historyLimit = 10000;
    terminal = "screen-256color";
    extraConfig = ''
      # VIM-like panel traversal
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
