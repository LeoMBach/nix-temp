{ config, pkgs, ... }:

let
  unstable = import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixos-unstable") {
    config = config.nixpkgs.config;
  };
in
{
  environment = {
    variables = { EDITOR = "vim"; };

    systemPackages = with pkgs; [
      ((vim_configurable.override { python = python3; }).customize {
        name = "vim";
        
        vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
          coc-css
          coc-eslint
          coc-html
          coc-json
          coc-nvim
          coc-prettier
          coc-yaml
          coc-yank
          fzf-vim
          fzfWrapper
          gruvbox
          nerdtree
          pear-tree
          syntastic
          vim-airline
          vim-commentary
          vim-devicons
          vim-fugitive
          vim-gitgutter
          vim-jsx-typescript
          vim-nix
          vim-surround
          vim-visual-multi

          unstable.pkgs.vimPlugins.coc-pyright
          unstable.pkgs.vimPlugins.vim-shellcheck

          # Disabled until a workaround/update is found for:
          # https://github.com/Xuyuanp/nerdtree-git-plugin/issues/141
          # nerdtree-git-plugin
        ];
        
        vimrcConfig.customRC = ''
          set encoding=utf-8

          let mapleader = ","

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

          set backupdir=/tmp//
          set directory=/tmp//
          set undodir=/tmp//

          " Default to 2-space tabs for certain filetypes
          autocmd FileType html             :setlocal sw=2 ts=2 sts=2
          autocmd FileType javascript       :setlocal sw=2 ts=2 sts=2
          autocmd FileType typescriptreact  :setlocal sw=2 ts=2 sts=2
          autocmd FileType yaml             :setlocal sw=2 ts=2 sts=2

          " Make backspace sane
          set backspace=eol,start,indent

          " Reduces delays with coc
          set updatetime=300

          " Always show signcolumn so that text doesn't shift when diagnostics are shown
          set signcolumn=yes

          " Coc tab completion
          inoremap <silent><expr> <TAB> 
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
          inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

          function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1] =~# '\s'
          endfunction

          " Use <cr> to confirm coc completion
          if has ("*complete_info")
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
          else
            inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
          endif

          " List stored yanks in coc-yank buffer
          nnoremap <silent> <Leader>y :<C-u>CocList -A --normal yank<cr>

          " GoTo code navigation.
          nnoremap <silent> gd <Plug>(coc-definition)
          nnoremap <silent> gy <Plug>(coc-type-definition)
          nnoremap <silent> gi <Plug>(coc-implementation)
          nnoremap <silent> gr <Plug>(coc-references)

          " Use <c-space> to trigger completion
          inoremap <silent><expr> <c-@> coc#refresh()

          " Project-wide file search
          nnoremap <Leader>p :FZF<CR>

          " Project-wide ripgrep search
          nnoremap <Leader>f :Rg<CR>

          filetype plugin on
          filetype indent on

          set wildmenu

          set noerrorbells
          set novisualbell

          " Auto-close Vim if NERDTree is the last open buffer
          autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

          map <Leader>b :NERDTreeToggle<CR>

          autocmd vimenter * colorscheme gruvbox
          set background=dark
        '';
      })
    ];
  };
}
