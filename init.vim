call plug#begin('~/.config/nvim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
map tt :NERDTreeToggle<CR>

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Color Scheme
Plug 'morhetz/gruvbox'
" Old colorscheme
Plug 'chriskempson/base16-vim'


" Bottom Bar
Plug 'vim-airline/vim-airline'

" Git handler
Plug 'airblade/vim-gitgutter'

call plug#end()

set nu

" NERDTree (filemanager)
let NERDTreeWinSize = 25

" Color Scheme
let base16colorspace=256
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'

" Clear search highlighting by Esc
nnoremap <silent> <esc> :nohlsearch<CR><esc>

" Git handler
let g:gitgutter_sign_column_always = 1

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
