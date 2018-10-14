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

" Start vim-plug in default plugin directory
call plug#begin('~/.config/nvim/vim-plug')

" Utilities
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Townk/vim-autoclose'
Plug 'neomake/neomake'

" Generic language support
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/syntastic'
Plug 'ajh17/VimCompletesMe'
Plug 'scrooloose/nerdcommenter'

" Languages support
Plug 'elmcast/elm-vim'
Plug 'heavenshell/vim-prettier'
Plug 'mustache/vim-mustache-handlebars'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'

" Themes / Interface
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'sickill/vim-monokai'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'vim-airline/vim-airline'

" Initialise vim-plug
call plug#end()


" =======================================
" 	CONFIGURATION
" =======================================

" Make tabs work propperly
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" User numbers
set number
" Highlight search matches
set hlsearch			

" Remove annoying swap files
set nobackup
set noswapfile
set noundofile

" Always display the status line
set laststatus=2

" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1
" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Down>    :resize +2<CR>
	nnoremap <Up>  :resize -2<CR>
	nnoremap <Right>  :vertical resize +2<CR>
	nnoremap <Left> :vertical resize -2<CR>
endif

" Enable highlighting of the current line
set cursorline

" =======================================
" Plugins Configuration
" =======================================

" Nerdcommenter
" Make commenting plugin work
filetype plugin on

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


" Format JS files on save
autocmd BufWritePost *.js,*.jsx call prettier#run(1)

" Colour theme 
syntax on
colorscheme dim
set t_Co=256

if (has("termguicolors"))
    set termguicolors
endif

" Neomake
" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rw', 1000)

" Syntastic  
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Checkers
let g:syntastic_javascript_checkers=['eslint']

" ====== File search =======
" Make sure we don't search in node_modules, git or elm-suff folders
let $FZF_DEFAULT_COMMAND ='find . -not -path "./node_modules/*" -not -path "./elm-stuff/*" -not -path "./.git/*"'

" Airline
let g:airline_powerline_fonts = 1 
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 

" Git gutter
" Disable from start
let g:gitgutter_enabled = 0
" Diable all key mappings
let g:gitgutter_map_keys = 0
" =======================================
"	KEY MAPPINGS
" =======================================

" Move lines up and down
nnoremap <C-j>  	:m .+1<CR>==
nnoremap <C-k>  	:m .-2<CR>==
nnoremap <C-Down> 	:m .+1<CR>==
nnoremap <C-Up> 	:m .-2<CR>==
inoremap <C-Down> 	<Esc> :m .+1<CR>==gi
inoremap <C-Up> 	<Esc> :m .-2<CR>==gi
vnoremap <C-Down> 	:m '>+1<CR>gv=gv
vnoremap <C-Up> 	:m '<-2<CR>gv=gv
vnoremap <C-j> 		:m '>+1<CR>gv=gv
vnoremap <C-k>	 	:m '<-2<CR>gv=gv

" Indent in Visual Model (we need to use 'autocmd VimEnter) so that this
" doesn't get overriden by plugins)
autocmd VimEnter * noremap <Tab> >>_
autocmd VimEnter * nnoremap <S-Tab> <<_
autocmd	VimEnter * inoremap <S-Tab> <C-D>
autocmd VimEnter * vnoremap <Tab> >gv
autocmd VimEnter * vnoremap <S-Tab> <gv

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>:wincmd p<CR>
" find currrently open file in nerdtree
nnoremap <leader>f :NERDTreeFind<CR>

" Toggle comment section
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

