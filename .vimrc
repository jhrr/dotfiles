execute pathogen#infect()

set nocompatible

syntax on
filetype plugin indent on

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set noswapfile

set ruler
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P

set autoindent
set autoread
set backspace=indent,eol,start
set expandtab
set hidden
set history=1000
set hlsearch
set incsearch
set ignorecase smartcase
set laststatus=2
set modeline
set modelines=3
set nowb
set noruler
set number
set scrolloff=3
set shiftwidth=4
set showcmd
set showmode
set smartcase
set smartindent
set smarttab
set softtabstop=4
set t_ti= t_te=
set tabstop=4
set title
set ttyfast
set tw=79
set visualbell
set wildmenu
set wildmode=list:longest

set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

set grepprg=ack\ -i

nnoremap ' `
nnoremap ` '
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

let mapleader = ","

inoremap jj <ESC>

runtime macros/matchit.vim

set t_Co=256
set background=dark

set statusline=[%n]\ %<%F\ \ \ %m%r%h%w%y[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ %{strftime(\"%H:%M\ \")}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd FileType js setlocal shiftwidth=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2
autocmd FileType sass setlocal shiftwidth=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
