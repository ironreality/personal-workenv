colorscheme ron

set nocompatible
syntax on
filetype plugin indent on
set autoindent

set number
set ruler
set showcmd

set hlsearch
set incsearch

set nobackup
set noswapfile

set tabstop=4
set expandtab
set shiftwidth=4
set backspace=2

set encoding=utf8

" osx clipboard integration
set clipboard=unnamed


"""
""" Plugins settings
"""

" load all plugins
packloadall
" load help files for all plugins
silent! helptags ALL

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
