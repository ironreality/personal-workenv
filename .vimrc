colorscheme ron

execute pathogen#infect()
syntax on
filetype plugin indent on

" backspace handling
set backspace=indent,eol,start

set number
set ruler

" highlight search results
set hlsearch

set nobackup
set noswapfile

" tabulation settings
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set tw=80

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" wrap git commit lines at 72 symbols
au FileType gitcommit setlocal tw=72

" restore the position in files
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
