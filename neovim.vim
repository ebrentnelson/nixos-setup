" Modern Neovim configuration - simplified and updated
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set timeoutlen=1000 ttimeoutlen=0

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
set hidden
set exrc

"turn on syntax highlighting
syntax on

" Change leader to a comma
let mapleader=","
let maplocalleader=","

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb
set backupcopy=yes

" ================ Persistent Undo ==================
if has('persistent_undo')
  silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
  set undodir=~/.config/nvim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=node_modules/**
set wildignore+=target/**
set wildignore+=__pycache__/**

" ================ Scrolling ========================

set scrolloff=8        "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Plugins =========================

call plug#begin('~/.config/nvim/plugged')

" Essential plugins only
Plug 'tpope/vim-fugitive'              " Git integration
Plug 'airblade/vim-gitgutter'          " Git diff in gutter
Plug 'vim-airline/vim-airline'         " Status line
Plug 'vim-airline/vim-airline-themes'  " Status line themes

" File navigation
Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder

" LSP and completion - using older compatible versions
Plug 'neovim/nvim-lspconfig', { 'tag': 'v0.1.6' }
Plug 'hrsh7th/nvim-cmp', { 'tag': 'v0.0.1' }
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" Language specific
Plug 'guns/vim-sexp', {'for': 'clojure'}     " S-expression editing
Plug 'Olical/conjure'                        " Clojure REPL integration
Plug 'gpanders/nvim-parinfer'                " Parinfer for Clojure

call plug#end()

set completeopt=menu,menuone,noselect

" ================ LSP and Completion Setup ========

lua << EOF
-- Simple LSP setup without Mason (manual install required)
local lspconfig = require('lspconfig')

-- Setup nvim-cmp
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- LSP setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Manual LSP server setup (install servers manually)
-- Clojure: Install clojure-lsp
lspconfig.clojure_lsp.setup({
  capabilities = capabilities,
})

-- Python: pip install python-lsp-server
lspconfig.pylsp.setup({
  capabilities = capabilities,
})

-- JavaScript: npm install -g typescript-language-server
lspconfig.tsserver.setup({
  capabilities = capabilities,
})

-- LSP key mappings
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Apply on_attach to all servers
lspconfig.clojure_lsp.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.pylsp.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
EOF

" ================ Plugin Configuration =============

" CtrlP
let g:ctrlp_map = '<C-f>'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|__pycache__'

" Netrw (built-in file explorer)
let g:netrw_banner = 0
let g:netrw_liststyle = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='minimalist'

" Clojure
let g:sexp_enable_insert_mode_mappings = 0

" ================ Display ==========================

set laststatus=2
set splitright
set splitbelow
set termguicolors
colorscheme default  " Using default colorscheme for simplicity

" ================ File Types =======================

filetype plugin indent on

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" File type specific settings
autocmd FileType javascript,typescript :setlocal sw=2 ts=2 sts=2
autocmd FileType html :setlocal sw=2 ts=2 sts=2
autocmd FileType python :setlocal sw=4 ts=4 sts=4
autocmd FileType clojure :setlocal sw=2 ts=2 sts=2
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
autocmd TermOpen * setlocal nonumber norelativenumber

" ================ Key Mappings =====================

" Window navigation
nmap <silent> \`<Up> :wincmd k<CR>
nmap <silent> \`<Down> :wincmd j<CR>
nmap <silent> \`<Left> :wincmd h<CR>
nmap <silent> \`<Right> :wincmd l<CR>

" Tab management
nnoremap <C-Insert> :tabnew<CR>
nnoremap <C-Delete> :tabclose<CR>
nnoremap <C-p> :tabprev<CR>
nnoremap <C-n> :tabnext<CR>

" Terminal mode escape
tnoremap <Esc> <C-\><C-n>

command! PrettyEDN %!clojure -M -e "(require '[clojure.pprint :as pp]) (pp/pprint (read-string (slurp *in*)))"

set secure
