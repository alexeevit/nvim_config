" Fuzzy finders in a floating window at the top of the screen:
"   <leader>t - files in the project (rg --files, respects .gitignore)
"   <leader>f - grep the current directory live, as you type
"   <leader>F - grep the current directory for a pattern, then filter the matches
"   <leader>; - open buffers
nnoremap <leader>t <Cmd>call <SID>files()<CR>
nnoremap <leader>f <Cmd>call <SID>live_grep()<CR>
nnoremap <leader>F <Cmd>call <SID>grep()<CR>
nnoremap <leader>; <Cmd>call <SID>buffers()<CR>

let s:finders = ['files', 'grep', 'live_grep', 'buffers']
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

" Live grep reruns rg on every change of the prompt (volatile), so the prompt
" is the rg pattern rather than a fuzzy filter. Items stay in rg's order.
call ddu#custom#patch_local('live_grep', #{
      \   sourceOptions: #{
      \     rg: #{ volatile: v:true, matchers: [], sorters: [] },
      \   },
      \ })

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

function! s:live_grep() abort
  call s:start('live_grep', [#{
        \   name: 'rg',
        \   options: #{ path: getcwd() },
        \   params: #{
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
" Filled while the live grep prompt is open
augroup ddu_finder_status
  autocmd!
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
  if b:ddu_ui_name ==# 'live_grep'
    augroup ddu_finder_status
      autocmd!
      autocmd CmdlineChanged * call s:status_update()
      autocmd User Ddu:uiRedraw call s:status_update()
    augroup END
    call s:status_update()
  endif
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
  autocmd! ddu_finder_status
  call s:status_show('')
endfunction

" Live grep status, right-aligned on the prompt line: "searching…" while rg
" runs for the current input, then the number of matches. Searching never
" blocks typing (ddu gets the input asynchronously), this only shows progress.
let s:status_win = -1
let s:status_text = ''
" Below this length the rg source doesn't search (minVolatileInputLength)
let s:min_input = 2
" The rg source stops after this many matches (maxEnqueSize)
let s:max_matches = 10000

function! s:status_update() abort
  let input = getcmdline()
  if strchars(input) < s:min_input
    call s:status_show('')
    return
  endif
  let status = s:live_grep_status()
  if !status->get('done', v:false) || status->get('input', '') !=# input
    call s:status_show('searching…')
  else
    let n = status.maxItems
    call s:status_show(n >= s:max_matches ? $'{n}+ matches'
          \ : n == 1 ? '1 match' : $'{n} matches')
  endif
endfunction

" What ddu-ui-ff last rendered in the live grep list: done, input, maxItems
function! s:live_grep_status() abort
  for winid in nvim_list_wins()
    if getbufvar(winbufnr(winid), 'ddu_ui_name') ==# 'live_grep'
      return getwinvar(winid, 'ddu_ui_ff_status', {})
    endif
  endfor
  return {}
endfunction

function! s:status_show(text) abort
  if a:text ==# s:status_text
    return
  endif
  let s:status_text = a:text
  if a:text ==# ''
    if s:status_win > 0 && nvim_win_is_valid(s:status_win)
      call nvim_win_close(s:status_win, v:true)
    endif
    let s:status_win = -1
    redraw
    return
  endif
  let width = strdisplaywidth(a:text) + 2
  let config = #{
        \   relative: 'editor',
        \   row: s:height,
        \   col: s:col + s:width - width,
        \   width: width,
        \   height: 1,
        \   focusable: v:false,
        \   zindex: 101,
        \ }
  if s:status_win > 0 && nvim_win_is_valid(s:status_win)
    call nvim_win_set_config(s:status_win, config)
  else
    let buf = nvim_create_buf(v:false, v:true)
    let s:status_win = nvim_open_win(buf, v:false, extend(config, #{
          \   style: 'minimal',
          \   noautocmd: v:true,
          \ }))
    call setwinvar(s:status_win, '&winhighlight', 'NormalFloat:DiffAdd')
  endif
  call nvim_buf_set_lines(winbufnr(s:status_win), 0, -1, v:true, [$' {a:text} '])
  redraw
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
