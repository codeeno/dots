"#######################
"General
"#######################

set nocompatible          " disable vi compatibility
syntax on                 " turn on syntax highlighting
filetype plugin indent on " Load plugins according to detected filetype.
set nu
set termguicolors

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set expandtab

"#######################
"Vundle
"#######################

filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'moll/vim-node'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdcommenter'
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasiser/vim-code-dark'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on " required

"#######################
"Plugins
"#######################

" auto open NERDTree when vim starts if vim was opened with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"#######################
"Keybinds
"#######################
let mapleader=" "

inoremap jk <ESC>:w<CR>

" Rebind toggle comments to CTRL-/
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle<CR>gv

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"#######################
"Visuals
"#######################
colorscheme codedark
