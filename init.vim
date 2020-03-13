call plug#begin('~/.local/share/nvim/plugged')

" Defaults
Plug 'tpope/vim-sensible'

" Local vimrc for each project
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

" System clipboard by <leader>
Plug 'lxhillwind/leader-clipboard'

" Colorscheme
Plug 'icymind/NeoSolarized'
Plug 'cocopon/iceberg.vim'

" Buttom info line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" File manager
Plug 'tpope/vim-vinegar'

" Fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Easy motion through a code
Plug 'easymotion/vim-easymotion'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting and copmletition
" Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace' " This plugin causes all trailing whitespace characters to be highlighted

" Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'slim-template/vim-slim'

" Python
Plug 'vim-python/python-syntax'

" PHP
Plug 'jwalton512/vim-blade', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }

" JS & TS
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/yajs.vim'

" Data formats
Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'chr4/nginx.vim'

call plug#end()

" Colorscheme
colorscheme iceberg
set termguicolors
set background=dark

" Numbers of lines
set nu

" Search settings
set hlsearch
set ignorecase
set smartcase

" Highlight column and line where is cursor
set cursorline
set cursorcolumn

" No show mode in status
set noshowmode

" Column left ot row-num for git symbols
set signcolumn=yes

" [] and {} highlighting
set showmatch

" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Backup and swap files
set nobackup
set nowritebackup
set nowb
set noswapfile

" Tab size
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set ts=2 sw=2 et

autocmd FileType ruby,javascript setlocal tabstop=2
autocmd BufRead,BufNewFile *.arb setfiletype ruby
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

nnoremap <silent><Esc> :nohlsearch<CR>
nnoremap <silent><C-TAB> :tabn<CR>
nnoremap <silent><C-S-TAB> :tabp<CR>
nnoremap <silent><C-T> :tabnew<CR>

" Don't use this binding because it breaks windows splitting by C-W-V and C-W-S
" nnoremap <silent><C-W> :tabclose<CR>

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with line wrapping on, this can cause the cursor to actually skip a few lines on the screen because it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down' to mean the next line on the screen
nnoremap <silent>j gj
nnoremap <silent>k gk

" Map ctrl-movement keys to window switching
nnoremap <silent><C-k> <C-w><Up>
nnoremap <silent><C-j> <C-w><Down>
nnoremap <silent><C-l> <C-w><Right>
nnoremap <silent><C-h> <C-w><Left>

" Escape mappings
imap jk <Esc>
imap JK <Esc>
imap kk <Esc>
imap KK <Esc>

" Enter command mode mappings
nnoremap ; :
vnoremap ; :
nnoremap Ж :
vnoremap Ж :
nnoremap ж :
vnoremap ж :

" Move rows to 1 tab with << or >>
vnoremap < <gv
vnoremap <s-lt> <gv
vnoremap > >gv

" Set leader key to space
let mapleader = "\<Space>"

" Lightline
let g:lightline = {}

let g:lightline.colorscheme = 'iceberg'

let g:lightline.component_function = {
\   'gitbranch': 'fugitive#head'
\ }

let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\ }
let g:lightline.active = {
\   'left': [
\     [ 'mode', 'paste' ],
\       [ 'gitbranch', 'readonly', 'filename', 'modified' ]
\     ],
\   'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
\ }

" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>s <Plug>(easymotion-overwin-f2)
nmap <Leader>ы <Plug>(easymotion-overwin-f2)

" EasyMotion configuration
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" coc
let g:coc_global_extensions = ['coc-solargraph']

" Vinegar
set wildignore+=*DS_Store*
set wildignore+=*.pyc
set wildignore+=*/.git/*
