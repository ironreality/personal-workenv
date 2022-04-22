" Set the folding method for vimrc
" vim:foldmethod=marker

" General settings {{{

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
  set encoding=utf8
  set formatoptions=tcqj
  set fsync
  set history=1000
  set hlsearch
  set incsearch
  set langnoremap
  set laststatus=2 " always show status line
  set ruler " ruler - line, column and % at the right bottom
  set showcmd " show last command in the status line
  set sidescroll=1
  set smarttab
  set viminfo+=!
  set wildmenu
endif

set number " display line numbers
set formatoptions+=o " continue comment marker in new lines.

set nobackup
set noswapfile

set tabstop=4
set expandtab
set shiftwidth=4
set backspace=2


" osx clipboard integration
set clipboard=unnamed

" comma is the leader key
let mapleader = ','

" }}}


" Plugins loading {{{

" load all plugins using vim-plug
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" put this file to ~/.vim/autoload/
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
call plug#end()

" }}}


" Theme and color {{{

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme molokai

" }}}


" ALE {{{

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:ale_completion_enabled = 1

" }}}


" vim-go {{{

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_addtags_transform = "snakecase"
let g:go_list_type = "quickfix"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" }}}


" airline {{{

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme='molokai'

" }}}


" vim-session {{{

let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" }}}


" Other plugins settings {{{

" NERDTree doesn't intercept netrw file browser
let NERDTreeHijackNetrw = 0

" open-browser.vim plugin
let g:netrw_nogx = 1 " disable netrw's gx mapping.

" }}}


" Commands {{{

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

" }}}


" Mappings configurationn {{{

" save file on Ctrl-S
nnoremap <C-s> :w<CR>
" switch off search results on Space
nnoremap <space> :nohl<CR>

" cycle through buffers
nnoremap <C-j> :bp<CR>
nnoremap <C-l> :bn<CR>
" close buffer
nnoremap <C-q> :bd<CR>

" resize windows with arrows
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" switch on/off NERDTree
map <C-n> :NERDTreeToggle<CR>

" open recent files menu (CtrlP)
map <C-r> :CtrlPMRU<CR>
nnoremap <C-B> :CtrlPBuffer<CR>

" open current link or selection in browser
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" run go code
nnoremap <leader>gr :GoRun %<CR>

" show all go func declarations from the current dir
au FileType go nmap <leader>gt :GoDeclsDir<cr>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" }}}
