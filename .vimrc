"#######################
"Plug
"#######################

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'flazz/vim-colorschemes'
Plug 'tomasiser/vim-code-dark'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

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
set shiftwidth=2
set softtabstop=2
set expandtab

let &t_ut='' " fix incorrect background rendering in kitty

"#######################
"NERDTree Stuff
"#######################

" auto open NERDTree when vim starts if vim was opened with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"#######################
"Keybinds
"#######################
let mapleader=" "

" Exit insert mode more comfortably
inoremap jk <ESC>:w<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Rebind toggle comments to CTRL-/
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle<CR>gv

" Toggle NERDTree
nmap <C-n> :NERDTreeToggle<CR>

" Easier tab navigation
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

"#######################
"Visuals
"#######################
colorscheme codedark

"smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

"#######################
"COC Stuff
"#######################
let g:coc_global_extensions = [ 'coc-snippets', 'coc-python', 'coc-rls', 'coc-tsserver', 'coc-json', ]

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
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
nnoremap <silent> K :call <SID>show_documentation()<CR>

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
