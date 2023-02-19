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

function! s:defx_get_siblings(soft) abort
  let paths = map(defx#get_candidates(), { i, file -> file.action__path })

  if defx#is_directory() && defx#is_opened_tree() && a:soft
    let parent = defx#get_candidate().action__path
  else
    let parent = fnamemodify(defx#get_candidate().action__path, ':h')
  endif

  return filter(paths, { i, path -> path =~ '^' . parent . '/' })
endfunction

function! s:defx_select_first_sibling() abort
  return defx#do_action('search', <sid>defx_get_siblings(0)[0])
endfunction

function! s:defx_select_last_sibling() abort
  return defx#do_action('search', <sid>defx_get_siblings(1)[-1])
endfunction

nnoremap <silent> tt
      \ :<C-u>Defx -resume -toggle<CR>
nnoremap <silent> tf
      \ :<C-u>Defx -resume -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
      \ 'resume': 1,
      \ 'winwidth': 40,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'columns': 'indent:icon:filename',
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ 'min_width': 20,
      \ 'max_width': 38,
      \ })

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal nonu signcolumn=no expandtab nowrap

  nnoremap <silent><buffer><expr> <C-k> <sid>defx_select_first_sibling()
  nnoremap <silent><buffer><expr> <C-j> <sid>defx_select_last_sibling()
  nnoremap <silent><buffer><expr> <C-o> defx#do_action('multi', ['drop', 'change_vim_cwd'])
	nnoremap <silent><buffer><expr> <CR>  <sid>defx_toggle_tree()
	nnoremap <silent><buffer><expr> l     defx#do_action('open_or_close_tree')
	nnoremap <silent><buffer><expr> h     defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> <C-t> defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
	nnoremap <silent><buffer><expr> <C-v>     defx#do_action('open', 'botright vsplit')
	nnoremap <silent><buffer><expr> <C-s>     defx#do_action('open', 'botright split')
	nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> %     defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> dd    defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> r     defx#do_action('rename')
	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
	nnoremap <silent><buffer><expr> q     defx#do_action('quit')

	" Defx's buffer management
	nnoremap <silent><buffer><expr> q      defx#do_action('quit')

	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')

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
