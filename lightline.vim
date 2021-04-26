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
