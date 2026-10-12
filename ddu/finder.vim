" Fuzzy finders in a floating window at the top of the screen:
"   <leader>t - files in the project (rg --files, respects .gitignore)
"   <leader>f - grep the current directory for a pattern, then filter the matches
"   <leader>; - open buffers
nnoremap <leader>t <Cmd>call <SID>files()<CR>
nnoremap <leader>f <Cmd>call <SID>grep()<CR>
nnoremap <leader>; <Cmd>call <SID>buffers()<CR>

let s:finders = ['files', 'grep', 'buffers']
let s:height = 20

for s:name in s:finders
  call ddu#custom#patch_local(s:name, #{
        \   ui: 'ff',
        \   uiParams: #{
        \     ff: #{
        \       split: 'floating',
        \       winRow: 0,
        \       winHeight: s:height,
        \       previewSplit: 'vertical',
        \       cursorPos: 1,
        \       highlights: #{ floating: 'Visual' },
        \     },
        \   },
        \   uiOptions: #{
        \     ff: #{
        \       filterPrompt: '> ',
        \       filterInputOptsFunc: 'cmdline#input_opts',
        \     },
        \   },
        \   sourceOptions: #{
        \     _: #{
        \       matchers: ['matcher_fzf'],
        \       sorters: ['sorter_length', 'sorter_fzf'],
        \     },
        \   },
        \   filterParams: #{
        \     matcher_fzf: #{ highlightMatched: 'QuickFixLine' },
        \   },
        \   kindOptions: #{
        \     file: #{ defaultAction: 'open' },
        \   },
        \ })
endfor

" Nearest directory with .git above the working directory, or the working
" directory itself if there is none
function! s:project_root() abort
  let dir = finddir('.git', getcwd() . ';')
  if !empty(dir)
    return fnamemodify(dir, ':p:h:h')
  endif
  let file = findfile('.git', getcwd() . ';')
  return empty(file) ? getcwd() : fnamemodify(file, ':p:h')
endfunction

" Start synchronously and open the filter prompt right away, so keys typed
" while the finder is opening land in the prompt
function! s:start(name, sources) abort
  let s:width = min([200, &columns - 2])
  let s:col = (&columns - s:width) / 2
  call ddu#start(#{
        \   name: a:name,
        \   sources: a:sources,
        \   sync: v:true,
        \   uiParams: #{ ff: #{ winWidth: s:width, winCol: s:col } },
        \ })
  call ddu#ui#do_action('openFilterWindow', {}, a:name)
endfunction

function! s:files() abort
  call s:start('files', [#{
        \   name: 'file_external',
        \   options: #{ path: s:project_root() },
        \   params: #{ cmd: ['rg', '--files', '--glob', '!.git'] },
        \ }])
endfunction

function! s:grep() abort
  let pattern = input('Pattern: ')
  if empty(pattern)
    return
  endif
  call s:start('grep', [#{
        \   name: 'rg',
        \   options: #{ path: getcwd() },
        \   params: #{
        \     input: pattern,
        \     args: ['--json', '--hidden', '--smart-case'],
        \     globs: ['!.git'],
        \   },
        \ }])
endfunction

function! s:buffers() abort
  call s:start('buffers', [#{ name: 'buffer' }])
endfunction

function! s:is_finder() abort
  return index(s:finders, get(b:, 'ddu_ui_name', '')) >= 0
endfunction

augroup ddu_finder
  autocmd!
  autocmd User Ddu:uiOpenFilterWindow call s:filter_settings()
  autocmd User Ddu:uiCloseFilterWindow call s:filter_cleanup()
  autocmd FileType ddu-ff call s:list_settings()
augroup END

" Filter prompt (command line, shown in a floating window right below the list):
"   <CR>          - open the selected item
"   <Esc>         - close the finder
"   <C-o>         - keep the filter and switch to the list
"   <C-t>         - open in a new tab
"   <C-v>         - open in a vertical split
"   <C-s>         - open in a horizontal split
function! s:filter_settings() abort
  if !s:is_finder()
    return
  endif
  call cmdline#set_option(#{
        \   row: s:height,
        \   col: s:col,
        \   width: s:width,
        \   border: 'none',
        \   highlight_window: 'DiffAdd',
        \ })
  call ddu#ui#save_cmaps(['<CR>', '<Esc>', '<C-o>', '<C-t>', '<C-v>', '<C-s>'])
  cnoremap <CR> <Cmd>call <SID>save_input()<CR><CR><Cmd>call <SID>filter_open('')<CR>
  cnoremap <Esc> <Esc><Cmd>call ddu#ui#do_action('quit')<CR>
  cnoremap <C-o> <CR>
  cnoremap <C-t> <Cmd>call <SID>save_input()<CR><CR><Cmd>call <SID>filter_open('tabedit')<CR>
  cnoremap <C-v> <Cmd>call <SID>save_input()<CR><CR><Cmd>call <SID>filter_open('vsplit')<CR>
  cnoremap <C-s> <Cmd>call <SID>save_input()<CR><CR><Cmd>call <SID>filter_open('split')<CR>
endfunction

function! s:save_input() abort
  let s:filter_input = getcmdline()
endfunction

" Filtering runs asynchronously while typing, so typing fast and pressing a key
" right away could act on a stale list. Finish filtering with the final input
" first, then open the item under the cursor.
function! s:filter_open(command) abort
  call ddu#denops#_request('redraw', [b:ddu_ui_name, #{ input: s:filter_input }])
  if empty(a:command)
    call ddu#ui#do_action('itemAction')
  else
    call s:open(a:command)
  endif
endfunction

function! s:filter_cleanup() abort
  if s:is_finder()
    call ddu#ui#restore_cmaps()
  endif
endfunction

function! s:open(command) abort
  call ddu#ui#do_action('itemAction', #{ name: 'open', params: #{ command: a:command } })
endfunction

" Result list:
"   <CR>        - open the selected item
"   q or <Esc>  - close the finder
"   d           - close the selected buffer (buffer list only)
"   p           - preview the selected item
"   <C-o> or i  - switch to the filter prompt
"   <C-t>       - open in a new tab
"   <C-v>       - open in a vertical split
"   <C-s>       - open in a horizontal split
function! s:list_settings() abort
  " The cursor stays in the first column, which cursorcolumn would highlight
  setlocal nocursorcolumn
  " The list holds lines from other files; ddu's doautocmd would otherwise
  " apply any of them that look like a modeline (e.g. "ex: Foo" -> E518)
  setlocal nomodeline

  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer><silent> <Esc>
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer><silent> p
        \ <Cmd>call ddu#ui#do_action('preview')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> <C-o>
        \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> <C-t> <Cmd>call <SID>open('tabedit')<CR>
  nnoremap <buffer><silent> <C-v> <Cmd>call <SID>open('vsplit')<CR>
  nnoremap <buffer><silent> <C-s> <Cmd>call <SID>open('split')<CR>
  if get(b:, 'ddu_ui_name', '') ==# 'buffers'
    nnoremap <buffer><silent> d
          \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'delete' })<CR>
  endif
endfunction
