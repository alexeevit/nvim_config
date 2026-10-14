let g:loaded_python3_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/bindings.vim
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
set signcolumn=yes " Always show the sign column (left of line numbers) for git signs
set showmatch " [] and {} highlighting
set scrolloff=1 " Keep a line of context above and below the cursor
set sidescrolloff=2 " Keep two columns of context left and right of the cursor
set display+=truncate " Show @@@ in the last line if it doesn't fit

" Enable hotkeys for Russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Search settings
set ignorecase
set smartcase

" Backup and swap files
set nowritebackup
set noswapfile

" How soon gitgutter refreshes its signs after you stop typing
set updatetime=100

" Tab size
set expandtab " allows to replace the tabs by white spaces characters
set shiftwidth=2 " makes the tabulations be 2 white spaces (for >> and friends)
set tabstop=2 " defines the number of spaces that a tab character in the file counts for (for <Tab>)

augroup init_filetypes
  autocmd!
  autocmd FileType nginx setlocal sw=4 ts=4
  autocmd FileType python setlocal sw=4 ts=4
  autocmd BufRead,BufNewFile *.arb setfiletype ruby
  " Neovim calls ERB 'eruby'; this makes modelines like 'vim: ft=erb' work
  autocmd FileType erb setlocal filetype=eruby
augroup END
