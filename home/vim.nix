{ pkgs, ... }:

{
    programs.vim = {
      enable = true;
      extraConfig = ''
        set encoding=utf8

        " Fuzzy finding
        set path +=**

        set number
        set numberwidth=2

        syntax enable

        " Show <row,col> at all times
        set ruler

        set showcmd

        " Highlight matching braces
        set showmatch

        set incsearch
        set hlsearch

        set ignorecase
        set smartcase

        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab

        " Default to 2-space tabs for certain filetypes
        autocmd FileType html       :setlocal sw=2 ts=2 sts=2
        autocmd FileType javascript :setlocal sw=2 ts=2 sts=2
        autocmd FileType yaml       :setlocal sw=2 ts=2 sts=2

        " Make backspace sane
        set backspace=eol,start,indent

        filetype plugin on
        filetype indent on

        set wildmenu

        set noerrorbells
        set novisualbell
      '';
    };
}
