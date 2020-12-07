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

" Rooter
let g:rooter_patterns = ['.git']

" if hidden is not set, TextEdit might fail.
set hidden

" Use system clipboard
set clipboard=unnamedplus

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
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap td  :tabclose<CR>

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
nnoremap Ж :
vnoremap Ж :
nnoremap ж :
vnoremap ж :

" Move rows to 1 tab with << or >>
vnoremap < <gv
vnoremap <s-lt> <gv
vnoremap > >gv

" Set leader key to space
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Lightline
let g:lightline = {}

let g:lightline.colorscheme = 'iceberg'

let g:lightline.component_function = {
\   'gitbranch': 'gitbranch#name'
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

" EasyMotion configuration
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)

" Vinegar
" set wildignore+=*DS_Store*
" set wildignore+=*.pyc

" To Avoid "E363: pattern uses more memory than 'maxmempattern'"
set mmp=5000

" To Avoid Error detected while processing function <lambda>19[1]..denite#_update_map[3]..denite#util#rpcrequest...
" https://github.com/Shougo/denite.nvim/issues/636#issuecomment-493271207
set history=1000

try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   -S:         Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
" \ 'auto_resize': 1,
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'winwidth': 200,
\ 'start_filter': 1,
\ 'source_names': 'short',
\ 'prompt': '> ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>J - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>J :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-s>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-s>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-s>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
        \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
        \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-s>
        \ denite#do_map('do_action', 'split')
endfunction

" === Defx settings === "

augroup user_plugin_defx
	autocmd!

	" Define defx window mappings
	autocmd FileType defx call <SID>defx_mappings()

	" Delete defx if it's the only buffer left in the window
	autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif

	" Move focus to the next window if current buffer is defx
	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

augroup END

" Internal functions
" ---

function! s:defx_toggle_tree() abort
	" Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop'])
endfunction

nnoremap <silent> <Leader>e
      \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <Leader>F
      \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
      \ 'resume': 1,
      \ 'winwidth': 35,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'columns': 'indent:icon:filename',
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no expandtab

	nnoremap <silent><buffer><expr> <C-o> defx#do_action('drop')
  nnoremap <silent><buffer><expr> O     defx#do_action('change_vim_cwd')
	nnoremap <silent><buffer><expr> <CR>  <sid>defx_toggle_tree()
	nnoremap <silent><buffer><expr> l     <sid>defx_toggle_tree()
	nnoremap <silent><buffer><expr> h     defx#async_action('cd', ['..'])
	nnoremap <silent><buffer><expr> <C-t> defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
	nnoremap <silent><buffer><expr> s     defx#do_action('open', 'botright vsplit')
	nnoremap <silent><buffer><expr> i     defx#do_action('open', 'botright split')
	nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
	nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> %     defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> dd    defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> r     defx#do_action('rename')
	"nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
	nnoremap <silent><buffer><expr> q     defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Tab> winnr('$') != 1 ?
	  \ ':<C-u>wincmd w<CR>' :
	  \ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'
	" Defx's buffer management
	nnoremap <silent><buffer><expr> q      defx#do_action('quit')
  " nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')

	" File/dir management
	nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
	nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
	nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
	nnoremap <silent><buffer><expr><nowait> r  defx#do_action('rename')
	nnoremap <silent><buffer><expr> dd defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> %  defx#do_action('new_multiple_files')

	" Change directory
	nnoremap <silent><buffer><expr><nowait> \  defx#do_action('cd', getcwd())
	nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
	nnoremap <silent><buffer><expr> <BS>  defx#async_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
	nnoremap <silent><buffer><expr> u   defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> 2u  defx#do_action('cd', ['../..'])
	nnoremap <silent><buffer><expr> 3u  defx#do_action('cd', ['../../..'])
	nnoremap <silent><buffer><expr> 4u  defx#do_action('cd', ['../../../..'])

	" Selection
	nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
  " nnoremap <silent><buffer><expr><nowait> <Space>
	"  \ defx#do_action('toggle_select') . 'j'

	nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'Time')
	nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')
endfunction
