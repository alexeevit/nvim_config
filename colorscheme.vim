" Colorscheme
function! s:IndentGuidesColors() abort
  if &background ==# 'dark'
    hi IndentGuidesOdd guibg=#1e2132 guifg=NONE
    hi IndentGuidesEven guibg=#232637 guifg=NONE
  else
    hi IndentGuidesOdd guibg=#dcdfe8 guifg=NONE
    hi IndentGuidesEven guibg=#e1deea guifg=NONE
  endif
endfunction

autocmd ColorScheme iceberg call s:IndentGuidesColors()

set background=light
colorscheme iceberg
set termguicolors
let g:lightline.colorscheme = 'iceberg'

" Follow the macOS light/dark appearance, checked asynchronously
" on startup and whenever Neovim regains focus.
function! s:SetBackground(job, code, event) abort
  let bg = a:code == 0 ? 'dark' : 'light'
  if &background !=# bg
    let &background = bg
    call LightlineReload()
  endif
endfunction

function! s:SyncBackground() abort
  call jobstart(['defaults', 'read', '-g', 'AppleInterfaceStyle'], #{
        \ on_exit: function('s:SetBackground'),
        \ })
endfunction

call s:SyncBackground()
autocmd FocusGained * call s:SyncBackground()
