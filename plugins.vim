call plug#begin(stdpath('data') . '/plugged')

" Defaults
Plug 'tpope/vim-sensible'

" Denite
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" DDU
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddu.vim'
Plug 'Shougo/ddu-ui-ff'
Plug 'Shougo/ddu-source-file'
Plug 'Shougo/ddu-source-file_rec'
Plug 'Shougo/ddu-filter-matcher_substring'
Plug 'Shougo/ddu-filter-sorter_alpha'
Plug 'Shougo/ddu-kind-file'
Plug 'Shougo/ddu-ui-filer'
Plug 'Shougo/ddu-column-filename'
Plug 'Shougo/ddu-filter-matcher_hidden'

" Colorscheme
Plug 'icymind/NeoSolarized'
Plug 'cocopon/iceberg.vim'

Plug 'f-person/auto-dark-mode.nvim'

Plug 'nathanaelkane/vim-indent-guides'

" Buttom info line
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" Auto chdir
" Plug 'airblade/vim-rooter'

" Pass line and column to open at in the path
Plug 'wsdjeg/vim-fetch'

" Easy motion through a code
Plug 'easymotion/vim-easymotion'

" Git
Plug 'airblade/vim-gitgutter'

" Linting and copmletition
Plug 'ntpeters/vim-better-whitespace' " This plugin causes all trailing whitespace characters to be highlighted

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" Rust
Plug 'rust-lang/rust.vim'

" Lua
Plug 'tbastos/vim-lua'

" Python
Plug 'vim-python/python-syntax'

" PHP
Plug 'jwalton512/vim-blade', { 'for': 'php' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }

" JS & TS
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/yajs.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Data formats
Plug 'elzr/vim-json'
Plug 'chr4/nginx.vim'

call plug#end()
