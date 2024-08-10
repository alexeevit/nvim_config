source ~/.config/nvim/plugins.vim
source ~/.config/nvim/bindings.vim
source ~/.config/nvim/denite.vim
source ~/.config/nvim/defx.vim
source ~/.config/nvim/easymotion.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/local_vimrc.vim
source ~/.config/nvim/rooter.vim
source ~/.config/nvim/colorscheme.vim
source ~/.config/nvim/indent_guides.vim

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
set expandtab " allows to replace the tabs by white spaces characters
set smarttab " a <Tab> in front of a line inserts blanks according to 'shiftwidth'
set shiftwidth=2 " makes the tabulations be 4 white spaces (for >> and friends)
set tabstop=2 " defines the number of spaces that a tab character in the file counts for (for <Tab>)

autocmd FileType nginx setlocal sw=4 ts=4
autocmd FileType python setlocal sw=4 ts=4
autocmd FileType javascript setlocal sw=4 ts=4
autocmd BufRead,BufNewFile *.arb setfiletype ruby
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

let g:ruby_host_prog = '~/.rbenv/versions/3.2.2/bin/neovim-ruby-host'
