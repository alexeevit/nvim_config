" Local vimrc file path
let g:local_vimrc = ['.config', '_vimrc_local.vim']
call lh#local_vimrc#munge('whitelist', $HOME.'/dev')
