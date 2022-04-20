colorscheme ron

" vim-specific settings
if !has('nvim')
  set nocompatible
  filetype plugin indent on
  syntax on
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set belloff=all
  set cscopeverbose
  set complete-=i
  set display=lastline,msgsep
  set encoding=utf8
  set formatoptions=tcqj
  set fsync
  set history=1000
  set hlsearch
  set incsearch
  set langnoremap
  set laststatus=2
  set ruler
  set showcmd
  set sidescroll=1
  set smarttab
  set viminfo+=!
  set wildmenu
endif

set number

set nobackup
set noswapfile

set tabstop=4
set expandtab
set shiftwidth=4
set backspace=2


" osx clipboard integration
set clipboard=unnamed


"""
""" Plugins settings
"""

" load all plugins using vim-plug
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" put this file to ~/.vim/autoload/
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'
call plug#end()

" NERDTreejackNetrw
let NERDTreeHijackNetrw = 0

" open-browser.vim plugin
let g:netrw_nogx = 1 " disable netrw's gx mapping.


"""
""" Mappings configurationn
"""

map <C-n> :NERDTreeToggle<CR>
map <C-r> :CtrlPMRU<CR>
nnoremap <C-B> :CtrlPBuffer<CR>
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
