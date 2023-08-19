set number
set relativenumber
" tab related
set sw=2
set shiftwidth=2
set tabstop=2
set expandtab
"other options
set nowrap
set scrolloff=8
set clipboard=unnamedplus
" search options
set hlsearch
set ignorecase
set smartcase
" leader key
let mapleader="\<Space>"
" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" navigate trough splits
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
" navigate trough buffers
map <S-l> $
map <S-h> ^

map <A-l> :bnext<CR>
map <A-h> :bprevious<CR>
"Clear search
map <leader>h :nohlsearch<Bar>:echo<CR>""
"Open file tree
map <leader>e :Lex 30<CR>
