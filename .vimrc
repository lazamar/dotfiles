" ===============================================================================
"   Marcelo Lazaroni Vim Config
" ===============================================================================

set nocompatible
syntax on
set nowrap
set encoding=utf8

" Both , and \ act as leader
let mapleader = ','
map \ <Leader>


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
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'sbdchd/neoformat'

" GHCIDE required
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes
Plug 'sickill/vim-monokai'
Plug 'kaicataldo/material.vim'
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'lazamar/candid.vim'

call plug#end()

" =======================================
" 	CONFIGURATION
" =======================================

" Enable mouse scroll
set mouse=a

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
" Enable buffer gutter all the time
set signcolumn=yes
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

" Enable highlighting current line
set cursorline

" Enable true colors
if (has('termguicolors'))
	set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set the colour scheme
syntax on
set t_Co=256
colorscheme candid

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
         let s .= '%T%#TabLine#%='
         return s
     endfunction
     set stal=1
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

" Reload files automaticall ywhen they are changed on disk
set autoread
" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" =======================================
" Plugins Configuration
" =======================================

"coc.nvim
" Make tab navigate through options
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Disable all silly mappings of NERDCommenter
let g:NERDCreateDefaultMappings = 0
autocmd VimEnter * nmap <C-_> <plug>NERDCommenterToggle
autocmd VimEnter * vmap <C-_> <plug>NERDCommenterToggle<CR>gv

" Git Signify
" Set vim updates for 100ms
set updatetime=100

" NerdTree
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
let g:airline_powerline_fonts = 1

" Neoformat
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_haskell = [ 'brittany', 'stylishhaskell' ]

" ======== FZF ===========
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let $FZF_PREVIEW_COMMAND = 'bat --style=numbers --color=always {} --map-syntax mu:hs --map-syntax scl:hs'

nmap <C-p>  :Files <CR>
nmap <C-l>  :Files $HOME<CR>

" Search command history
nmap <C-c>  :History:<space><CR>

" Search available commands
nmap <Leader>c  :Commands<CR>

" Search word under the cursor project-wide with K
nnoremap K  :Ag! <C-R><C-W><CR>
" Search all tags
nnoremap T  :Tags<CR>
" Search tag under the cursor
nnoremap gt :Tags <C-R><C-W><CR>

" Search a Haskell or Mu definition of word under the cursor project-wide
nnoremap <Leader>D :Ag! ((newtype\|type\|data\|class)<space><C-R><C-W>\|<C-R><C-W> ::)<CR>
" Search type definition, function definition with and without signatures
nnoremap <Leader>d /\(\(newtype\\|type\\|data\\|class\)<space><C-R><C-W>\>\\|\<<C-R><C-W> ::\\|\n\s\+\(let\)\?\s\+<C-R><C-W> .*=\)<CR>

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
" To be used with fast-tags
let preview_file = plugins_dir . "/fzf.vim/bin/preview.sh"

command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \      'down': '40%',
  \      'options': '
  \         --with-nth 1,2
  \         --preview-window="top:70%"
  \         --preview ''' . preview_file . ' {2}:$(echo {3} | cut -d ";" -f 1)'''
  \ }, <bang>0)

let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'haskell': ['ghcide', '--lsp'],
    \ }

" =======================================
"	KEY MAPPINGS
" =======================================

" Use arrows to resize screen
nnoremap <Down>     :resize +2<CR>
nnoremap <Up>       :resize -2<CR>
nnoremap <Right>    :vertical resize +2<CR>
nnoremap <Left>     :vertical resize -2<CR>

" Faster scrolling
nnoremap <C-d> 6<C-e>
nnoremap <C-u> 6<C-y>

" Resize windows easily
map <Leader><Down>     :resize +4<CR>
map <Leader><Up>       :resize -4<CR>
map <Leader><Right>    :vertical resize +4<CR>
map <Leader><Left>     :vertical resize -4<CR>

" Quickly start a string replacement
nnoremap <Leader>r :%s/<C-r><C-W>
vnoremap <Leader>r "ay::%s/<C-r>a/

" --- Terminal ---
if has("nvim")
    " Make C-W take terminal to normal mode
    tmap <C-w> <C-\><C-n><C-w>
endif

"Open terminal with our setup file loaded
nmap <Leader>T            :vsplit \| execute "terminal" \| startinsert <CR>
tmap <Leader>T  <C-\><C-n>:vsplit \| execute "terminal" \| startinsert <CR>
nmap <Leader>t            :split  \| execute "terminal" \| startinsert <CR>
tmap <Leader>t  <C-\><C-n>:split  \| execute "terminal" \| startinsert <CR>

" Force quit a window
tnoremap <Leader>q <C-\><C-n>:bd!<CR>
noremap  <Leader>q      <C-w>:bd!<CR>


" Fast buffer switching
" next buffer
nnoremap <Leader>n           :bnext<CR>
tnoremap <Leader>n <C-\><C-n>:bnext<CR>
" previous buffer
nnoremap <Leader>p           :bprevious<CR>
tnoremap <Leader>p <C-\><C-n>:bprevious<CR>
" Show all open buffers
nnoremap <Leader><Space>          :Buf<CR>
tnoremap <Leader><Space> <C-\><C-n>:Buf<CR>

" Delete current buffer without losing window
nnoremap <C-w>d      :bp<CR><C-w>:bd #<CR>

" Fast tab switching
function! s:MapTabKey(tabNumber)
    execute "nnoremap <Leader>" . a:tabNumber . " :" a:tabNumber . "tabn<CR>"
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

" Recover selection after indenting
" we need to use 'autocmd VimEnter so that this doesn't get overriden by plugins
autocmd VimEnter * vnoremap > >gv
autocmd VimEnter * vnoremap < <gv
