set nocompatible

syntax on

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
set shiftwidth=2
set showcmd
set showmode
set smartcase
set smartindent
set smarttab
set softtabstop=2
set t_ti= t_te=
set tabstop=2
set title
set visualbell
set wildmenu
set wildmode=list:longest

filetype plugin on
filetype indent on

set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nnoremap ' `
nnoremap ` '
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

let mapleader = ","

runtime macros/matchit.vim

set t_Co=256
set background=dark

"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

set statusline=[%n]\ %<%F\ \ \ %m%r%h%w%y[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ %{strftime(\"%H:%M\")}
