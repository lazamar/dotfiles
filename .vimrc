" ===============================================================================
"   Marcelo Lazaroni Vim Config
" ===============================================================================

set nocompatible
syntax on
set nowrap
set encoding=utf8

" =======================================
" Plugins Installation
" =======================================

call plug#begin('~/.config/nvim/vim-plug')

" Utilities
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'

" Themes
Plug 'sickill/vim-monokai'
Plug 'kaicataldo/material.vim'
Plug 'joshdick/onedark.vim'

call plug#end()

" =======================================
" 	CONFIGURATION
" =======================================

" Make tabs work propperly
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Use numbers
set number
" Highlight search matches
set hlsearch
" Search incrementally
set incsearch

" Remove annoying swap files
set nobackup
set noswapfile
set noundofile

" Always display the status line
set laststatus=2

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo " This has to Exist! mkdir ~/.vim/undo
set undolevels=1000
set undoreload=10000

" Disable arrow movement, resize splits instead.
let g:elite_mode=1
if get(g:, 'elite_mode')
    nnoremap <Down>     :resize +2<CR>
    nnoremap <Up>       :resize -2<CR>
    nnoremap <Right>    :vertical resize +2<CR>
    nnoremap <Left>     :vertical resize -2<CR>
endif

" Enable highlighting current line
set cursorline

" Enable true colors
if (has('termguicolors'))
	set termguicolors
endif

" Set the colour scheme
syntax on
set t_Co=256
let g:material_theme_style = 'palenight'
colorscheme material

" --- Fast string searches ---
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Show tab numbers in tab bar
if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let s .= ' ' . i . ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif

" =======================================
" Plugins Configuration
" =======================================

" NerdCommenter
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" NerdTree
" Show hidden files
let NERDTreeShowHidden=1
let g:NERDTreeDirArrows = 0
let g:NERDTreeShowGitStatus = 1
let g:NERDTreeUpdateOnWrite = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \  }

" Airline
let g:airline_theme='onedark'

" Neoformat
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_haskell = [ 'brittany', 'stylishhaskell' ]
" Format on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" Git gutter
" Disable from start
let g:gitgutter_enabled = 0
" Diable all key mappings
let g:gitgutter_map_keys = 0

" ======== FZF ===========
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nmap <C-p>  :FZF -i<CR>

nmap <C-c>  :Commands<space><CR>
"start a project-wide search by pressing \
nnoremap \  :Ag<space>
" Search word under the cursor with K
nnoremap K  :Ag <C-R><C-W><CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Make fzf match the colour scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" =======================================
"	KEY MAPPINGS
" =======================================

" --- Terminal ---
"Open terminal with our setup file loaded
nnoremap <C-t>  :tab   terminal bash --init-file ~/.bash_profile<CR>
command  Term   :below terminal bash --init-file ~/.bash_profile

" Fast buffer switching
" next buffer
nnoremap mn :bnext<CR>
tnoremap mn <C-w>:bnext<CR>
" previous buffer
nnoremap mp :bprevious<CR>
tnoremap mp <C-w>:bprevious<CR>

" Fast tab switching
function! s:MapTabKey(tabNumber)
    execute "nnoremap m" . a:tabNumber . " :" a:tabNumber . "tabn<CR>" 
    execute "tnoremap m" . a:tabNumber . " <C-W>:" a:tabNumber . "tabn<CR>"
    execute "inoremap m" . a:tabNumber . " <Esc>:" a:tabNumber . "tabn<CR>"
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
