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

let plugins_dir = '~/.config/nvim/vim-plug'
call plug#begin(expand(plugins_dir))

" Utilities
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'sbdchd/neoformat'

" GHCIDE required
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" Themes
Plug 'sickill/vim-monokai'
Plug 'kaicataldo/material.vim'
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

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
" set number
" Highlight search matches
set hlsearch
" Search incrementally
set incsearch
" Make search case insensitive
set ignorecase
" Make search case sensitive if you type any capitalised letter
set smartcase
" Allow erasing past beginning of insert position
set backspace=indent,eol,start

" Remove annoying swap files
set nobackup
set noswapfile

" Always display the status line
set laststatus=2

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo " This has to Exist! mkdir ~/.vim/undo
set undolevels=1000
set undoreload=10000

" Save a long history of Vim commands
set history=10000

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
colorscheme onehalfdark

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

" Sane space characters when using `set list`
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·

" Remove spaces on save
autocmd BufWritePre * %s/\s\+$//e

" Use Haskell syntax highlighting for Mu files
autocmd BufRead,BufNewFile *.mu set filetype=haskell
" Use Haskell syntax highlighting for SCL files
autocmd BufRead,BufNewFile *.scl set filetype=haskell

" Formatters
command  FormatJSON      :%!jq '.'
command  FormatHaskell   :Neoformat

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" =======================================
" Plugins Configuration
" =======================================

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

" Git gutter
" Diable all key mappings
let g:gitgutter_map_keys = 0

" Neoformat
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_haskell = [ 'brittany', 'stylishhaskell' ]

" ======== FZF ===========
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let $FZF_PREVIEW_COMMAND = 'bat --style=numbers --color=always {} --map-syntax mu:hs --map-syntax scl:hs'

nmap <C-p>  :Files <CR>
nmap <C-l>  :Files $L<CR>

" Search command history
nmap <C-c>  :History:<space><CR>
" Search word under the cursor project-wide with K
nnoremap K  :Ag! <C-R><C-W><CR>
nnoremap T  :Tags <C-R><C-W><CR>

" Search a Haskell or Mu definition of word under the cursor project-wide
nnoremap mD :Ag! ((newtype\|type\|data\|class)<space><C-R><C-W>\|<C-R><C-W> ::)<CR>

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

" Ag! will show search in full screen
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview('right:50%'), <bang>0)

" Files! will show search in full screen with preview
command! -bang -nargs=* Files
  \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('right:50%') : {}, <bang>0)

" Send file address and line number to fzf.vim's preview script
let preview_file = plugins_dir . "/fzf.vim/bin/preview.sh"
let show_preview = 'FILE=;LINE=;F={};for word in $F;do if [ -n "$word" ] & [ "$word" -eq "$word" ] 2>/dev/null;then LINE=$word;break;fi;FILE=$word;done;echo $FILE:$LINE | xargs -I {} ' . preview_file . '  {}'

command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \      'down': '40%',
  \      'options': '
  \                  --with-nth 1,2
  \                  --preview-window="top:70%"
  \                  --preview ''' . show_preview . ''''
  \ }, <bang>0)

" --- vim-lsp ---
au User lsp_setup call lsp#register_server({
    \ 'name': 'ghcide',
    \ 'cmd': {server_info->['~/.local/bin/ghcide', '--lsp']},
    \ 'whitelist': ['haskell'],
    \ })

" =======================================
"	KEY MAPPINGS
" =======================================

" Quickly start a string replacement
nnoremap <Leader>r :%s/

" --- Terminal ---
"Open terminal with our setup file loaded
nnoremap <C-t>  :tab   terminal bash --rcfile ~/.bash_profile<CR>
command  Term   :below terminal bash --rcfile ~/.bash_profile

" Force quit a window
tnoremap <C-w>Q <C-w>:bd!<CR>
noremap  <C-w>Q <C-w>:bd!<CR>

" Fast buffer switching
" next buffer
nnoremap <Leader>] :bnext<CR>
tnoremap <Leader>] <C-w>:bnext<CR>
" previous buffer
nnoremap <Leader>[ :bprevious<CR>
tnoremap <Leader>[ <C-w>:bprevious<CR>
" Show all open buffers
nnoremap <Leader><Space> :Buf<CR>
" Delete current buffer without losing window
nnoremap <C-w>d :bp<CR><C-w>:bd #<CR>
tnoremap <C-w>d <C-w>:bp!<CR><C-w>:bd #<CR>

" Fast tab switching
function! s:MapTabKey(tabNumber)
    execute "nnoremap m" . a:tabNumber . " :" a:tabNumber . "tabn<CR>"
    execute "tnoremap m" . a:tabNumber . " <C-W>:" a:tabNumber . "tabn<CR>"
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
