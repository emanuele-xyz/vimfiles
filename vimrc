" ------------------------------------------------------------------------------
"        _
"       (_)
" __   ___ _ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
" ------------------------------------------------------------------------------
" GVIM
" ------------------------------------------------------------------------------

" Do not show tool/menu bar
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b

" Use built-in tab style instead of gui
set guioptions-=e

" Set gvim font
set guifont=Consolas:h14

" ------------------------------------------------------------------------------
" BASIC SETUP
" ------------------------------------------------------------------------------

" Enter the current millennium
set nocompatible

" No swap and backup files
set noswapfile
set nobackup
set nowritebackup

" Enable syntax highlighting and plugins
syntax enable
filetype plugin on

" Auto indent new lines
set autoindent
" Use spaces instead of tabs
set expandtab
" Number of auto-indent spaces
set shiftwidth=4
" Enable smart-indent
set smartindent
" Enable smart-tabs
set smarttab
" Number of spaces per Tab
set softtabstop=4

" Set relative and absolute line number
set relativenumber
set number

" Break lines
set linebreak
set showbreak=+++

" Highlight matching brace
set showmatch

" Always show the status bar
set laststatus=2

" Search down into subfolders
set path=**

" Enhanced tab completion
set wildmenu wildmode=full

" Make backspace work
set backspace=indent,eol,start

" Number of undo levels
set undolevels=1024

" Use spaces instead of tabs. A tab equals to 4 spaces
" Hitting tab vim will inset four spaces. Also indent using four spaces
set  shiftwidth=4 expandtab smarttab

" Highlight all search results
set hlsearch

" enable smart case search
set smartcase

" Do case insensitive search
set ignorecase

" Show incremental search results as you type
set incsearch

" Save before switching buffers and many other things
set autowriteall

" Set history length
set history=1024

" Default registers are shared with the system clipboard
set clipboard+=unnamed

" Don't use the alt key to map on window shortcuts
set winaltkeys=no

" Disable annoying error beeping
set belloff=all

" Don't save buffers when switching between them
set hidden

" netrw window proportion
let g:netrw_winsize=15

" netrw disable banner
let g:netrw_banner=0

" Set color scheme
colorscheme codedark

" ------------------------------------------------------------------------------
" STATUS LINE
" ------------------------------------------------------------------------------

set statusline=
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ |

" ------------------------------------------------------------------------------
" AUTOMATICALLY LOAD LOCAL CONFIGURATION FILE AT STARTUP
" ------------------------------------------------------------------------------

if filereadable("project.vim")
    source project.vim
endif

" ------------------------------------------------------------------------------
" CUSTOM COMMANDS
" ------------------------------------------------------------------------------

command -nargs=0 CmdProjectList call CmdProjectList()
function CmdProjectList()
    exe "vimgrep /\\%^/j src/**/*.c include/**/*.h"
endfunction

command -nargs=1 CmdProjectSearch call CmdProjectSearch(<q-args>)
function CmdProjectSearch(pattern)
    exe "vimgrep /" . a:pattern . "/j src/**/*.c include/**/*.h"
endfunction

command -nargs=0 CmdVendorList call CmdVendorList()
function CmdVendorList()
    exe "vimgrep /\\%^/j vendor/**/*.c vendor/**/*.h"
endfunction

command -nargs=1 CmdVendorSearch call CmdVendorSearch(<q-args>)
function CmdVendorSearch(pattern)
    exe "vimgrep /" . a:pattern . "/j vendor**/*.c vendor/**/*.h"
endfunction

" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------

" Set <leader> to space
let mapleader = " "

" Quick edit and source config file
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" List all project files (project list)
nnoremap <leader>pl :CmdProjectList<cr>
" Search through all project files for a pattern (project search)
nnoremap <leader>ps :CmdProjectSearch<space>

" List all vendor files (vendor list)
nnoremap <leader>vl :CmdVendorList<cr>
" Search through all vendor files for a pattern (vendor search)
nnoremap <leader>vs :CmdVendorSearch<space>

" Better scrolling
" Scroll up by one line
nnoremap <A-k> <C-y>
" Scroll up by half page
nnoremap <A-K> <C-u>
" Scroll down by one line
nnoremap <A-j> <C-e>
" Scroll down by half page
nnoremap <A-J> <C-d>

" Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Better window resizing
" nnoremap <C-J> :resize +5 <cr>
" nnoremap <C-K> :resize -5 <cr>
" nnoremap <C-H> :vertical resize -5 <cr>
" nnoremap <C-L> :vertical resize +5 <cr>

" Use tab/shift+tab to go to next/previous buffer
nnoremap <Tab>   :bn<cr>
nnoremap <S-Tab> :bp<cr>

" Better quickfix
nnoremap <F9>  :vert botright copen 100<cr>
nnoremap <F10> :cn<cr>
nnoremap <F11> :cp<cr>
nnoremap <F12> :cclose<cr>
nnoremap <A-h> :colder<cr>
nnoremap <A-l> :cnewer<cr>

" ------------------------------------------------------------------------------
" AUTO COMMANDS
" ------------------------------------------------------------------------------

augroup vimrcgroup
    " Automatically open quickfix if there are matches
    " autocmd!
    " autocmd QuickFixCmdPost [^l]* cwindow
    " autocmd QuickFixCmdPost l*    lwindow

    " Maximize on gui startup
    autocmd GUIEnter * simalt ~x

    " trim whitespaces on save
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" ------------------------------------------------------------------------------
