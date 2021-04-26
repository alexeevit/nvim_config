nnoremap <C-p> "0p
vnoremap <C-p> "0p

nnoremap <silent><Esc> :nohlsearch<CR>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
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
