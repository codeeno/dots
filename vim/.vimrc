"#######################
"Plug
"#######################

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter' 
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go'

" Colorschemes
Plug 'mhartington/oceanic-next'
Plug 'kaicataldo/material.vim'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'tomasiser/vim-code-dark'

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

let &t_ut='' " fix incorrect background rendering in kitty

"#######################
"Keybinds
"#######################
let mapleader="\<Space>"

" Quick suspend vim
nnoremap <leader><leader> :stop<CR>

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
nnoremap <silent> <Leader>, :vertical resize +5<CR>
nnoremap <silent> <Leader>. :vertical resize -5<CR>

" Rebind toggle comments to CTRL-/
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle<CR>gv

" Toggle NERDTree
nmap <leader>n :NERDTreeToggle<CR>

" Easier tab navigation
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" copying/pasting to/from system clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p

" Some fzf bindings
nnoremap <leader>f  :GFiles<CR>
nnoremap <leader>li :Lines<CR>
nnoremap <leader>gi :GFiles?<CR>

"#######################
"Visuals
"#######################

" Colorscheme
set background=dark
let g:lightline = { 'colorscheme': 'palenight' }
let g:palenight_terminal_italics=1
colorscheme palenight
"colorscheme codedark


" Change highlight colors
highlight CocHighlightText  ctermbg=237 guibg=#3E4452
highlight CocHighlightRead  ctermbg=237 guibg=#3E4452
highlight CocHighlightWrite ctermbg=237 guibg=#3E4452
highlight Matchparen        ctermbg=237 guibg=#3E4452
highlight CocErrorSign                  guifg=#ff5370

"#######################
"Misc
"#######################

"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ }
      \ }
function! LightlineFilename()
  return expand('%')
endfunction

let g:terraform_fmt_on_save=1

"#######################
"fzf Configs
"#######################

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

"#######################
"NERDTree Configs
"#######################

" Close NERDTree if it is the last remaining buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" auto open NERDTree when vim starts if vim was opened with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"#######################
"COC Configs
"#######################

let g:coc_global_extensions = [ 'coc-snippets', 'coc-python', 'coc-rust-analyzer', 'coc-tsserver', 'coc-json', 'coc-eslint']

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> <C-K> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

