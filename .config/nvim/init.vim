
" ===============================================================================
"   Marcelo Lazaroni Vim Config
" ===============================================================================

set notermguicolors
colorscheme vim

set nocompatible
syntax on
set nowrap
set encoding=utf8

" Both , and \ act as leader
let mapleader = ','
map \ <Leader>

" =======================================
" KEY MAPPINGS
" =======================================

" Make pasting over a selection not override the copied register
vnoremap p "_dP

" Copy into the OS clipboard
vnoremap Y "+y
nnoremap Y "+y

" Make smartcase not apply in * and # searches
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap // :nohlsearch<CR>

" Copy file path
" Relative
nnoremap yp         :let @" = expand("%")<CR>
" Absolute
nnoremap yP         :let @" = expand("%:p")<CR>

" Use arrows to resize screen
nnoremap <Down>     :resize +2<CR>
nnoremap <Up>       :resize -2<CR>
nnoremap <Right>    :vertical resize +2<CR>
nnoremap <Left>     :vertical resize -2<CR>

" Faster scrolling
nnoremap <C-d> 6<C-e>
nnoremap <C-u> 6<C-y>

" Quickly start a string replacement
nnoremap <Leader>r :%s/<C-r><C-W>
vnoremap <Leader>r "ay::%s/<C-r>a/

" Quickly start a string search
nmap <Leader>f :Rg<Space>

" Make C-W take terminal to normal mode
tmap <C-w> <C-\><C-n><C-w>

" Go into normal mode with two escapes
tnoremap <Leader><Leader> <C-\><C-N>

"Open terminal with our setup file loaded
nmap <Leader>T            :vsplit \| execute "terminal" \| startinsert <CR>
tmap <Leader>T  <C-\><C-n>:vsplit \| execute "terminal" \| startinsert <CR>
nmap <Leader>t            :split  \| execute "terminal" \| startinsert <CR>
tmap <Leader>t  <C-\><C-n>:split  \| execute "terminal" \| startinsert <CR>

" Force quit a window
tnoremap <Leader>q <C-\><C-n>:bd!<CR>
nnoremap <Leader>q :bd!<CR>

" Quickly move through quickfix list
nmap <C-j> :cnext<CR>
nmap <C-k> :cprev<CR>

" Open a quickfix window with the selected content
vnoremap <Leader>q  y:cexpr @"<CR>:copen<CR>

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

" Create new tabs
nmap tt :tabnew<CR>

" Fast tab switching
" Use <Leader><NUMBER> to select tab
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

" =======================================
" Plugins Installation
" =======================================

let plugins_dir = '~/.config/nvim/vim-plug'
call plug#begin(expand(plugins_dir))

" Utilities
Plug 'http://github.com/tpope/vim-surround'
Plug 'http://github.com/tpope/vim-repeat'
Plug 'http://github.com/scrooloose/nerdcommenter'
Plug 'http://github.com/scrooloose/nerdtree'
Plug 'http://github.com/mhinz/vim-signify'

" Fuzzy finder
Plug 'http://github.com/junegunn/fzf'
Plug 'http://github.com/junegunn/fzf.vim'

" Language support
" Plug 'http://github.com/sheerun/vim-polyglot'
" Tree-sitter is not very good yet.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'master' }
" View tags on the sidebar
Plug 'preservim/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'http://github.com/pappasam/jedi-language-server', { 'branch': 'main' }
Plug 'http://github.com/mfussenegger/nvim-lint'

" LSP
" Enables Neovim's native LSP
Plug 'neovim/nvim-lspconfig'
" Autocompletion with Neovim's native LSP
Plug 'hrsh7th/nvim-compe'

call plug#end()

" =======================================
" Plugins Configuration
" =======================================

" ======== compe ===========
" Enable compe's completion
set completeopt=menuone,noselect
" compe's settings
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}
EOF

" ======== Neovim's LSP ===========
lua << EOF
-- setup language servers
local lspconfig = require('lspconfig')

-- Enable errors showing in-line
vim.diagnostic.config({ virtual_text = true })

lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- haskell language server
lspconfig.hls.setup {}

-- Elm language server
lspconfig.elmls.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end,
}

-- TypeScript language server
lspconfig.ts_ls.setup {}

-- Python language server
lspconfig.jedi_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	lsp_flags = lsp_flags,
})
lint = require('lint')
lint.linters_by_ft = {
  python = {'mypy', 'ruff'},
}
lint.linters.mypy.cmd = 'pipenv'
lint.linters.mypy.args = {
  'run',
  'mypy',
  '--show-column-numbers',
  '--show-error-end',
  '--hide-error-context',
  '--no-color-output',
  '--no-error-summary',
  '--no-pretty',
}
lint.linters.ruff.cmd = 'pipenv'
ruff_old_args = lint.linters.ruff.args
lint.linters.ruff.args = { 'run', 'ruff', unpack(ruff_old_args) }

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

-- Use internal formatting for bindings like gq.
 vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(args)
     vim.bo[args.buf].formatexpr = nil
   end,
 })
EOF

" ======== Treesitter ===========
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "javascript",
    "lua",
    "markdown",
    "python",
    "vimdoc",
    "yaml",
    "c",
    "haskell",
    "json",
    "markdown_inline",
    "query",
    "rust",
    "typescript",
    "vim",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { },

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 1000 * 1024 -- 1MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" ======== rust-lang  ===========
" Run rustfmt on save
let g:rustfmt_autosave = 1

" ======== NERDCommenter ===========
" Disable all silly mappings of NERDCommenter
let g:NERDCreateDefaultMappings = 0
autocmd VimEnter * nmap <C-_> <plug>NERDCommenterToggle
autocmd VimEnter * vmap <C-_> <plug>NERDCommenterToggle<CR>gv

" ======== vim-signify ===========
" Set vim updates for 1000ms
set updatetime=1000

" ======== NerdTree ===========
let NERDTreeShowHidden=1

" Toggle side bar
nmap <Leader>` :NERDTreeToggle<CR>
" Reveal in side bar
nmap <Leader>F :NERDTreeFind<CR>

" ======== FZF ===========
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Key bindings in search window
" Use <C-a><C-q> to get results into a quickfix window.
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Search project files
nmap <C-p>  :Files <CR>

" Search command history
nmap <C-c>  :History:<space><CR>

" Search available commands
nmap <Leader>c  :Commands<CR>

" Search word under the cursor project-wide with K
nnoremap K  :Rg! <C-R><C-W><CR>
" Search all tags
nnoremap T  :Tags<CR>
" Search tag under the cursor
nnoremap gt :Tags <C-R><C-W><CR>

" Search a Haskell definition of word under the cursor project-wide
nnoremap <Leader>D :Rg! ((newtype\|type\|data\|predicate\|class)<space><C-R><C-W>\|<C-R><C-W> ::)<CR>
" Search type definition, function definition with and without signatures
nnoremap <Leader>d /\(\(newtype\\|type\\|data\\|predicate\\|class\)<space><C-R><C-W>\>\\|\<<C-R><C-W>\n*\s*::\\|\n\s\+\(let\)\?\s\+<C-R><C-W> .*=\)<CR>

" Send file address and line number to fzf.vim's preview script
" To be used with fast-tags
let preview_file = plugins_dir . "/../fzf-preview.sh"

command! -bang -nargs=* Tags
  \ call fzf#vim#tags(<q-args>, {
  \      'window': { 'width': 0.9, 'height': 0.6 },
  \      'options': '
  \         --with-nth 1,2
  \         --preview-window="right:70%"
  \         --preview ''' . preview_file . ' {2}:$(echo {3} | cut -d ";" -f 1)'''
  \ }, <bang>0)

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }

" =======================================
"   NEOVIM CONFIGURATION (no plugin)
" =======================================
" This comes after plugin setup so that
" plugin settings may not override it.

" Enable mouse scroll
set mouse=a

" Make tabs work properly
filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set signcolumn=auto
" Remove annoying swap files
set nobackup
set noswapfile
set spelllang=en_gb

" Allow going beyond line end with cursor
set virtualedit=all

" Always display the status line
set laststatus=2

" Custom status line
set statusline=
set statusline+=%#LeftSection#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#RightSection#
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ %y
set statusline+=\ |

" Persistent undo
set undofile
set undodir=$HOME/.config/nvim/undo " This has to Exist! mkdir ~/.config/nvim/undo
set undolevels=1000
set undoreload=10000

" Save a long history of Vim commands
set history=10000

" Enable highlighting current line
set cursorline

" --- Fast string searches ---
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
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

" Use Haskell syntax highlighting
autocmd BufRead,BufNewFile *.hsc   set filetype=haskell
autocmd BufRead,BufNewFile *.x     set filetype=haskell  " Alex files
autocmd BufRead,BufNewFile *.y     set filetype=haskell  " Happy files
autocmd BufRead,BufNewFile *.angle set filetype=haskell  " Angle files
" Use Python syntax highlighting
autocmd BufRead,BufNewFile *.tw set filetype=python    " Tupperware
autocmd BufRead,BufNewFile *.sky set filetype=python    " Tupperware
" Identify Markdown
autocmd BufRead,BufNewFile *.md   set syntax=markdown

" Formatters
command! FormatJSON      :%!jq '.'

" Reload files automaticall when they are changed on disk
set autoread

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

