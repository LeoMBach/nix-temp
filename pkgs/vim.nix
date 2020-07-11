{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; with vimPlugins; [
        vim_configurable

        syntastic
        vim-airline
        vim-commentary
        vim-gitgutter
        vim-surround
    ];
}
