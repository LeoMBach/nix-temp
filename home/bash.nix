{ pkgs, ... }:

{
    programs.bash = {
        shellAliases = {
            ls = "ls --color=auto";
            ll = "ls -l";
            lla = "ls -la";
            llha = "ls -lha";

            grep = "grep --color";

            cls = "clear";
            dir = "ls -l";
        };
    };
}
