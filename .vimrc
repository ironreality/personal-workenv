" Set the folding method for vimrc
" vim:foldmethod=marker

" General settings {{{

set nocompatible
filetype plugin indent on
syntax on

set autoindent " take indent for new line from previous line
set autoread " reload file if the file changes on the disk
set autowrite " write when switching buffers
set backspace=indent,eol,start
set belloff=all
set cscopeverbose
set complete-=i
set encoding=utf8
set formatoptions=tcqronj " set vims text formatting options
set fsync
set history=1000
set hlsearch
set incsearch
set langnoremap
set laststatus=2 " always show status line
set ruler " ruler - line, column and % at the right bottom
set showcmd " show last command in the status line
set cmdheight=1 "give more space for displaying messages
set updatetime=300 " default is 4000 ms = 4 s
set shortmess+=c " don't pass messages to |ins-completion-menu|
set hidden "TextEdit might fail if hidden is not set
set sidescroll=1
set colorcolumn=81 " highlight the 80th column as an indicator
set viminfo+=!
set wildmenu
set list " show trailing whitespace
set listchars=tab:\·\ ,extends:›,precedes:‹,nbsp:˙,trail:▫
set number " display line numbers
set relativenumber
set formatoptions+=o " continue comment marker in new lines.

set nobackup
set noswapfile

set tabstop=4
set expandtab " expands tabs to spaces
set smarttab
set shiftwidth=4
set backspace=2

" Compete options for the pop up menu for autocompletion.
set completeopt=menu,noselect

" remove the horrendous preview window
set completeopt-=preview

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-nginx', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" }}}


" Theme and color {{{

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme molokai

" }}}


" coc {{{

let g:coc_global_extensions = ['coc-go', 'coc-pyls', 'coc-pydocstring',
  \ 'coc-css', 'coc-html', 'coc-eslint', 'coc-yaml', 'coc-json',
  \ 'coc-markdownlint', 'coc-sh', 'coc-swagger', 'coc-toml']

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
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme='molokai'

" }}}


" vim-session {{{

let g:session_autoload = "no"
let g:session_autosave = "yes"
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
" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" cycle through buffers
nnoremap <C-j> :bp<CR>
nnoremap <C-l> :bn<CR>
" close buffer
nnoremap <C-q> :bd<CR>

" use <Esc> in the normal way in terminal mode
:tnoremap <Esc> <C-\><C-n>

" resize windows with arrows
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" switch on/off NERDTree
map <C-n> :NERDTreeToggle<CR>

" open recent files menu (CtrlP)
map <leader>r :CtrlPMRU<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" open current link or selection in browser
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" run go code
nnoremap <leader>gr :GoRun %<CR>
nnoremap <leader>gt :GoTest .<CR>

" show all go func declarations from the current dir
au FileType go nmap <leader>gd :GoDeclsDir<cr>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sod :OpenSession default<CR>
nnoremap <leader>ssd :SaveSession default<CR>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" }}}

" {{{ Language specific settings

"----------------------------------------------
" Language: Bash
"----------------------------------------------
au FileType sh set noexpandtab
au FileType sh set shiftwidth=2
au FileType sh set softtabstop=2
au FileType sh set tabstop=2

"----------------------------------------------
" Language: gitcommit
"----------------------------------------------
au FileType gitcommit setlocal spell
au FileType gitcommit setlocal textwidth=80

"----------------------------------------------
" Language: fish
"----------------------------------------------
au FileType fish set expandtab
au FileType fish set shiftwidth=2
au FileType fish set softtabstop=2
au FileType fish set tabstop=2

"----------------------------------------------
" Language: gitconfig
"----------------------------------------------
au FileType gitconfig set noexpandtab
au FileType gitconfig set shiftwidth=2
au FileType gitconfig set softtabstop=2
au FileType gitconfig set tabstop=2

"----------------------------------------------
" Language: HTML
"----------------------------------------------
au FileType html set expandtab
au FileType html set shiftwidth=2
au FileType html set softtabstop=2
au FileType html set tabstop=2

"----------------------------------------------
" Language: CSS
"----------------------------------------------
au FileType css set expandtab
au FileType css set shiftwidth=2
au FileType css set softtabstop=2
au FileType css set tabstop=2

"----------------------------------------------
" Language: JavaScript
"----------------------------------------------
au FileType javascript set expandtab
au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType javascript set tabstop=2

"----------------------------------------------
" Language: JSON
"----------------------------------------------
au FileType json set expandtab
au FileType json set shiftwidth=2
au FileType json set softtabstop=2
au FileType json set tabstop=2

"----------------------------------------------
" Language: Make
"----------------------------------------------
au FileType make set noexpandtab
au FileType make set shiftwidth=2
au FileType make set softtabstop=2
au FileType make set tabstop=2

"----------------------------------------------
" Language: Markdown
"----------------------------------------------
au FileType markdown setlocal spell
au FileType markdown set expandtab
au FileType markdown set shiftwidth=4
au FileType markdown set softtabstop=4
au FileType markdown set tabstop=4
au FileType markdown set syntax=markdown
au FileType markdown set textwidth=80

"----------------------------------------------
" Language: Protobuf
"----------------------------------------------
au FileType proto set expandtab
au FileType proto set shiftwidth=2
au FileType proto set softtabstop=2
au FileType proto set tabstop=2

"----------------------------------------------
" Language: Python
"----------------------------------------------
au FileType python set expandtab
au FileType python set shiftwidth=4
au FileType python set softtabstop=4
au FileType python set tabstop=4

"----------------------------------------------
" Language: Ruby
"----------------------------------------------
au FileType ruby set expandtab
au FileType ruby set shiftwidth=2
au FileType ruby set softtabstop=2
au FileType ruby set tabstop=2

"----------------------------------------------
" Language: SQL
"----------------------------------------------
au FileType sql set expandtab
au FileType sql set shiftwidth=2
au FileType sql set softtabstop=2
au FileType sql set tabstop=2

"----------------------------------------------
" Language: TOML
"----------------------------------------------
au FileType toml set expandtab
au FileType toml set shiftwidth=2
au FileType toml set softtabstop=2
au FileType toml set tabstop=2

"----------------------------------------------
" Language: TypeScript
"----------------------------------------------
au FileType typescript set expandtab
au FileType typescript set shiftwidth=4
au FileType typescript set softtabstop=4
au FileType typescript set tabstop=4

"----------------------------------------------
" Language: vimscript
"----------------------------------------------
au FileType vim set expandtab
au FileType vim set shiftwidth=4
au FileType vim set softtabstop=4
au FileType vim set tabstop=4

"----------------------------------------------
" Language: YAML
"----------------------------------------------
au FileType yaml set expandtab
au FileType yaml set shiftwidth=2
au FileType yaml set softtabstop=2
au FileType yaml set tabstop=2

" }}}

" fzf settings
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <C-g> :Rg<Cr>
nnoremap <C-f> :Files<Cr>
