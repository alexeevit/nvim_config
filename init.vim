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

" Buttom info line
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
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

" Linting and copmletition
Plug 'ervandew/supertab'
Plug 'w0rp/ale'
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
colorscheme NeoSolarized
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
set shiftwidth=4
set softtabstop=4
set tabstop=4
set ts=4 sw=4 et

autocmd FileType ruby setlocal tabstop=2
autocmd BufRead,BufNewFile *.arb setfiletype ruby
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

nnoremap <silent><Esc> :nohlsearch<CR>
nnoremap <silent><C-TAB> :tabnext<CR>
nnoremap <silent><C-S-TAB> :tabprevious<CR>

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
vnoremap > >gv

" Set leader key to space
let mapleader = "\<Space>"

" Lightline
let g:lightline = {}

let g:lightline.colorscheme = 'solarized'

let g:lightline.component_function = {
\   'gitbranch': 'fugitive#head'
\ }

let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ }

let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\ }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

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

" Ale
let g:ale_completion_enabled = 1
let g:ale_php_phpcs_standard = 'PSR12'
let g:ale_php_phpcs_executable = expand('~/.composer/vendor/bin/phpcs')
let g:ale_php_phpcs_use_global = 1
let g:ale_php_langserver_use_global = 1
let g:ale_php_langserver_executable = expand('~/.composer/vendor/bin/php-language-server.php')
let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'tsserver'],
\   'python': ['pyls']
\ }
let g:ale_javascript_tsserver_use_global = 1
let g:ale_javascript_eslint_use_global = 1

set completeopt+=noinsert " Dont autocomplete

map <silent>gd :ALEGoToDefinition<CR>
map <silent>gr :ALEFindReferences<CR>
nnoremap <silent>[c <Plug>(ale_previous_wrap)
nnoremap <silent>]c <Plug>(ale_next_wrap)

" Vinegar
set wildignore+=*DS_Store*
set wildignore+=*.pyc
set wildignore+=*/.git/*
