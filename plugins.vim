call plug#begin(stdpath('data') . '/plugged')

" Defaults
Plug 'tpope/vim-sensible'

" Denite
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Local vimrc for each project
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

" Colorscheme
Plug 'icymind/NeoSolarized'
Plug 'cocopon/iceberg.vim'

" Buttom info line
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" File manager
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" Auto chdir
Plug 'airblade/vim-rooter'

" Pass line and column to open at in the path
Plug 'wsdjeg/vim-fetch'

" Easy motion through a code
Plug 'easymotion/vim-easymotion'

" Git
Plug 'airblade/vim-gitgutter'

" Linting and copmletition
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
