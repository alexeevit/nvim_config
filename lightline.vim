" Lightline
let g:lightline = {}

let g:lightline.component_function = {
\   'gitbranch': 'LightlineGitbranch',
\   'mode': 'LightlineMode',
\   'cwd': 'LightlineCwd',
\   'filename': 'LightlineFilename',
\ }

function! LightlineFilename()
  let modified = &modified ? '+' : ''
  let filename = expand('%') . modified
  return &filetype ==# 'defx' ? '' : filename
endfunction

function! LightlineGitbranch()
  return &filetype ==# 'defx' ? '' : gitbranch#name()
endfunction

function! LightlineMode()
  return &filetype ==# 'defx' ? 'defx' : lightline#mode()
endfunction

function! LightlineCwd()
  return &filetype ==# 'defx' ? '' : getcwd()
endfunction

function! LightlineReload() abort
  execute 'runtime autoload/lightline/colorscheme/' . g:lightline.colorscheme . '.vim'
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

command! LightlineReload call LightlineReload()

let g:lightline.active = {
\   'left': [
\       [ 'mode', 'paste' ],
\       [ 'gitbranch', 'readonly', 'filename' ]
\   ],
\   'right': [['cwd']]
\ }

let g:lightline.inactive = {
\   'left': [[]],
\   'right': [['filename']]
\ }
