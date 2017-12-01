if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('slim-template/vim-slim')
  call dein#add('tpope/vim-haml')
  call dein#add('tpope/vim-endwise')

  call dein#add('scrooloose/nerdtree')

  call dein#add('elzr/vim-json')

  call dein#add('ajmwagar/vim-deus')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('jiangmiao/auto-pairs')

  call dein#end()
  call dein#save_state()
endif

syntax enable
filetype plugin indent on
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
"let g:deus_termcolors=256

"set noswapfile

cd ~/dev
nmap tt :NERDTreeToggle<CR>
let g:NERDTreePath = '~/dev'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

set termguicolors
" Color Scheme
colorscheme deus

" Clear search highlighting by Esc
nnoremap <silent> <esc> :nohlsearch<CR><esc>

" Git handler
" let g:gitgutter_sign_column_always = 1

set nu

" Tab size
set shiftwidth=2
set softtabstop=2
set tabstop=2
set ts=2 sw=2 et

" Move rows to 1 tab with << or >>
vmap < <gv
vmap > >gv

set showmatch     " set show matching parenthesis

" Screen jump
set scrolljump=7
set scrolloff=7

set clipboard+=unnamedplus

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"set cursorline   " highlight current line
set cursorcolumn " highlight current column
