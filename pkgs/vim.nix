{ pkgs, ... }:

{
  environment = {
    variables = { EDITOR = "vim"; };

    systemPackages = with pkgs; [
      ((vim_configurable.override { python = python3; }).customize {
        name = "vim";
        
        vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
          coc-nvim
          fzf-vim
          fzfWrapper
          gruvbox
          nerdtree
          nerdtree-git-plugin
          syntastic
          vim-airline
          vim-commentary
          vim-devicons
          vim-fugitive
          vim-gitgutter
          vim-surround
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

          " Use <cr> to confirm Coc completion
          if has ("*complete_info")
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
          else
            inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
          endif

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

          map <C-b> :NERDTreeToggle<CR>

          autocmd vimenter * colorscheme gruvbox
          set background=dark
        '';
      })
    ];
  };
}
