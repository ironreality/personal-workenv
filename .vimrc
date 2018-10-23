colorscheme ron

execute pathogen#infect()
syntax on
filetype plugin indent on

set number

set nobackup
set noswapfile

" search
"set ignorecase

" navigation speed up
nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l


" vim-terraform - https://github.com/hashivim/vim-terraform
" let g:terraform_align=1
" let g:terraform_fold_sections=1
" let g:terraform_remap_spacebar=1
" let g:terraform_commentstring='//%s'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif