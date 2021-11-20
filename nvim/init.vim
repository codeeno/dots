"#######################
"Plug
"#######################

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim' "Helper for other Plugins
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/dashboard-nvim'

" Colorschemes
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()

"#######################
"General
"#######################

set nocompatible          " disable vi compatibility
syntax on                 " turn on syntax highlighting
filetype plugin indent on " Load plugins according to detected filetype.
set nu
set termguicolors         " Required for many colorschemes

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set expandtab
set splitbelow
set splitright
set backspace=indent,eol,start

"#######################
"Vanilla Keybinds
"#######################

let mapleader="\<Space>"

" Quick suspend vim
nnoremap <leader>e :stop<CR>

" Quick Save
nnoremap <leader>s :update<CR>

" Exit insert mode more comfortably and save
inoremap jk <ESC>:w<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" More ergonomic way to scroll up/down fast
nnoremap J 10j
nnoremap K 10k

" Vertical resize
nnoremap <silent> <Leader>, :vertical resize +10<CR>
nnoremap <silent> <Leader>. :vertical resize -10<CR>

" Easier tab navigation
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
nnoremap <Tab>     :tabnext<CR>
nnoremap <S-Tab>   :tabprevious<CR>

" copying/pasting to/from system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

"#######################
"Plugin specific Keybinds
"#######################

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Open NERDTree at current buffer
map <leader>r :NERDTreeFind<cr>

" Bi-directional easymotion
nmap s <Plug>(easymotion-bd-f)

" Toggle NERDTree
nmap <leader>n :NERDTreeToggle<CR>

" Rebind toggle comments to CTRL-/
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle<CR>gv

"#######################
"Plugin specific settings
"#######################

" dashboard-nvim
let g:dashboard_default_executive ='treesitter'

"#######################
"Visuals
"#######################

" Colorscheme
set background=dark
let g:lightline = { 'colorscheme': 'palenight' }
let g:palenight_terminal_italics=1
colorscheme palenight

" Change highlight colors
highlight CocHighlightText  ctermbg=237 guibg=#3E4452
highlight CocHighlightRead  ctermbg=237 guibg=#3E4452
highlight CocHighlightWrite ctermbg=237 guibg=#3E4452
highlight Matchparen        ctermbg=237 guibg=#3E4452
highlight CocErrorSign                  guifg=#ff5370
