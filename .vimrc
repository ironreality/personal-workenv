colorscheme ron

execute pathogen#infect()
syntax on
filetype plugin indent on

set number

" highlight search results
set hlsearch
" turn off highlighting with Space
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set nobackup
set noswapfile

" search
"set ignorecase

" navigation speed up
nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l

" tabulation settings
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" vim-terraform - https://github.com/hashivim/vim-terraform
" let g:terraform_align=1
" let g:terraform_fold_sections=1
" let g:terraform_remap_spacebar=1
" let g:terraform_commentstring='//%s'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Groovy syntax for Jenkinsfiles
"autocmd BufNewFile,BufRead Jenkinsfile set syntax=json

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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

function! InsMdCollapse()
  r~/.vim/templates/md_collapse.tpl
endfunction

:command InsMdClps call InsMdCollapse()
