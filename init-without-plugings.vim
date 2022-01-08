" Minimal vim configuration

set nocompatible
syntax on
set nowrap
set encoding=utf8

" Both , and \ act as leader
let mapleader = ','
map \ <Leader>

"Open terminal
nmap <Leader>T            :vsplit \| execute "terminal" \| startinsert <CR>
tmap <Leader>T  <C-\><C-n>:vsplit \| execute "terminal" \| startinsert <CR>
nmap <Leader>t            :split  \| execute "terminal" \| startinsert <CR>
tmap <Leader>t  <C-\><C-n>:split  \| execute "terminal" \| startinsert <CR>

" Force quit a window
tnoremap <Leader>q <C-\><C-n>:bd!<CR>
nnoremap <Leader>q :bd!<CR>

" Make C-W take terminal to normal mode
tmap <C-w> <C-\><C-n><C-w>

" Fast buffer switching
" next buffer
nnoremap <Leader>n           :bnext<CR>
tnoremap <Leader>n <C-\><C-n>:bnext<CR>
" previous buffer
nnoremap <Leader>p           :bprevious<CR>
tnoremap <Leader>p <C-\><C-n>:bprevious<CR>
" Show all open buffers
nnoremap <Leader><Space>          :Buf<CR>

" Delete current buffer without losing window
nnoremap <C-w>d      :bp<CR><C-w>:bd #<CR>

" Fast tab switching
function! s:MapTabKey(tabNumber)
	execute "nnoremap <Leader>" . a:tabNumber . " :" a:tabNumber .  "tabn<CR>"
	execute "tnoremap <Leader>" . a:tabNumber . " <C-\\><C-n>:" a:tabNumber . "tabn<CR>"
endfunction

call s:MapTabKey(1)
call s:MapTabKey(2)
call s:MapTabKey(3)
call s:MapTabKey(4)
call s:MapTabKey(5)
call s:MapTabKey(6)
call s:MapTabKey(7)
call s:MapTabKey(7)
call s:MapTabKey(8)
call s:MapTabKey(9)
