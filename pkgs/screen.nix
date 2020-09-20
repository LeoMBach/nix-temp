{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [ pkgs.screen ];
  programs.screen.screenrc = ''
    startup_message off

    defscrollback 10000

    # Always show a status bar at the bottom of the screen
    hardstatus alwayslastline

    # Allow scrolling in xterms
    termcapinfo xterm|xterms|xs ti@:te=\E[2J

    # Format status bar to be useful
    hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{= kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B} %m-%d %{W}%c %{g}]'

    # In case there's any doubt!
    setenv USING_SCREEN true
  '';
}
