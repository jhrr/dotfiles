set nocompatible

execute pathogen#infect()

syntax on
filetype plugin indent on

colors zenburn

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set noswapfile

set ruler
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P

set autoindent
set autoread
set backspace=indent,eol,start
" set clipboard=unamedplus,unnamed,autoselect
set expandtab
set fileformat=unix
set fileformats=unix,dos
set formatoptions-=t
set hidden
set history=1000
set hlsearch
set incsearch
set ignorecase smartcase
set laststatus=2
set modeline
set modelines=3
set nofixendofline
set noruler
set nowb
set number
" set relativenumber
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

nmap <silent> <leader>s :set nolist!<CR>

exe "set rtp+=" . $BREW_PREFIX . "/opt/fzf"

nnoremap ' `
nnoremap ` '
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

let mapleader = ","

inoremap jj <ESC>
" inoremap <S-Tab> <C-V><Tab>
nnoremap <Leader>c :bd<CR>
nnoremap <Leader>p :r !pbpaste<CR>
nnoremap <Leader>s :shell<CR>
nnoremap <Leader>S :StripWhitespace<CR>
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>m :Snippets<CR>

"Unset "last search pattern" register by hitting return.
nnoremap <CR> :noh<CR><CR>

" Copy to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Reformat JSON block
" :%!python -m json.tool

runtime macros/matchit.vim

set t_Co=256
set background=dark

set statusline=[%n]\ %<%F\ \ \ %m%r%h%w%y[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\
set statusline+=\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ %{strftime(\"%H:%M\ \")}

" Highlight lines breaking column 80 on a per-line basis.
highlight ColorColumn ctermfg=208 ctermbg=Black

function! MarkMargin (on)
    if exists('b:MarkMargin')
        try
            call matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    endif
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\S', 100)
    endif
endfunction

augroup MarkMargin
    autocmd!
    autocmd BufEnter * :call MarkMargin(1)
    autocmd BufEnter *.vp* :call MarkMargin(0)
augroup END

" File navigation
nnoremap ; :Buffers<CR>
nnoremap <Leader>h :Files<CR>
nnoremap <Leader>j :GFiles<CR>
nnoremap <Leader>f :GFiles?<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>L :noh<CR>
nnoremap <Leader>t :e ./TODO.org<CR>

" Formatting
let g:rustfmt_autosave = 1
autocmd FileType nix setlocal commentstring=#\ %s
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType vue syntax sync fromstart
autocmd FileType vue setlocal commentstring=//\ %s

" SuperCollider
" ,b -> Start server.
" ,o -> Run line of code.
" ,i -> Run block of code.
" ,k -> Kill the server completely.
" ,. -> Hard stop.
" K  -> Open help file.
" ^] -> Jump to tagfile.
let g:scTerminalBuffer="on"
let g:scSplitDirection="v"
let hostname = substitute(system("hostname"), "\n", "", "")
let g:scSplitSize = '50%'
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au Filetype supercollider packadd scvim
au Filetype supercollider nnoremap <leader>b :call SClangStart()<CR>
au Filetype supercollider inoremap <leader>b :call SClangStart()<CR>
au Filetype supercollider vnoremap <leader>b :call SClangStart()<CR>
au Filetype supercollider nnoremap <leader>o :call SClang_line()<CR>
au Filetype supercollider inoremap <leader>o :call SClang_line()<CR>
au Filetype supercollider vnoremap <leader>o :call SClang_line()<CR>
au Filetype supercollider nnoremap <leader>i :call SClang_block()<CR>
au Filetype supercollider inoremap <leader>i :call SClang_block()<CR>
au Filetype supercollider vnoremap <leader>i :call SClang_block()<CR>
au Filetype supercollider nnoremap <leader>. :call SClangHardstop()<CR>
au Filetype supercollider inoremap <leader>. :call SClangHardstop()<CR>
au Filetype supercollider vnoremap <leader>. :call SClangHardstop()<CR>
au Filetype supercollider nnoremap <leader>k :call SClangKill()<CR>
au Filetype supercollider inoremap <leader>k :call SClangKill()<CR>
au Filetype supercollider vnoremap <leader>k :call SClangKill()<CR>

" ALE
" TODO: :help ale-go-to-definition
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_virtualenv_dir_names = ['venv', '.venv']
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {
\   'javascript': ['prettier', 'eslint'],
\   'vue': ['prettier', 'eslint'],
\   'python': ['mypy', 'flake8'],
\   'rust': ['rls'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'vue': ['prettier', 'eslint'],
\   'python': ['isort', 'yapf'],
\   'rust': ['rustfmt'],
\}
nnoremap <Leader>l :ALEFix<CR>

"Ultisnips
let g:UltiSnipsExpandTrigger = '<c-j>'
" let g:UltiSnipsJumpForwardTrigger = '<c-b>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-z>'

" Mu-complete
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c
set belloff+=ctrlg
let g:mucomplete#completion_delay = 1

" Change cursor shape between insert and normal mode in iTerm2
if $TERM_PROGRAM =~ "iTerm"
  if empty($TMUX)
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  else
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
endif
