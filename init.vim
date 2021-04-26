source ~/.config/nvim/plugins.vim
source ~/.config/nvim/bindings.vim
source ~/.config/nvim/denite.vim
source ~/.config/nvim/defx.vim
source ~/.config/nvim/easymotion.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/local_vimrc.vim
source ~/.config/nvim/rooter.vim

" It hides buffers instead of closing them.
" This means that you can have unwritten changes
" to a file and open a new file using :e, without
" being forced to write or undo your changes first.
" Also, undo buffers and marks are preserved
" while the buffer is open.
set hidden

set clipboard=unnamedplus " Use system clipboard
set nu " Show line numbers
set cursorline " Highlight column under cursor
set cursorcolumn " Highlight line under cursor
set noshowmode " No show mode in status because we already have it in lightline
set signcolumn=yes " Column left ot row-num for git symbols
set showmatch " [] and {} highlighting

" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Colorscheme
colorscheme iceberg
set termguicolors
set background=dark

" Search settings
set hlsearch
set ignorecase
set smartcase

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
set shiftround

autocmd FileType ruby,javascript setlocal tabstop=2
autocmd BufRead,BufNewFile *.arb setfiletype ruby
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
