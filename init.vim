let g:python3_host_prog = "~/.config/nvim/.python-venv/bin/python3"

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/bindings.vim
source ~/.config/nvim/denite.vim
source ~/.config/nvim/ddu.vim
source ~/.config/nvim/easymotion.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/colorscheme.vim
source ~/.config/nvim/indent_guides.vim
lua require('treesitter')

set clipboard=unnamedplus " Use system clipboard
set nu " Show line numbers
set cursorline " Highlight line under cursor
set cursorcolumn " Highlight column under cursor
set noshowmode " No show mode in status because we already have it in lightline
set signcolumn=yes " Column left ot row-num for git symbols
set showmatch " [] and {} highlighting
set history=10000 " Neovim's default; set explicitly so vim-sensible doesn't lower it to 1000

" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Search settings
set ignorecase
set smartcase

" Backup and swap files
set nowritebackup
set noswapfile

" Mostly for gitgutter, but it's the delay before vim writes to its swap file
set updatetime=100

" Tab size
set expandtab " allows to replace the tabs by white spaces characters
set shiftwidth=2 " makes the tabulations be 2 white spaces (for >> and friends)
set tabstop=2 " defines the number of spaces that a tab character in the file counts for (for <Tab>)

autocmd FileType nginx setlocal sw=4 ts=4
autocmd FileType python setlocal sw=4 ts=4
autocmd BufRead,BufNewFile *.arb setfiletype ruby
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
