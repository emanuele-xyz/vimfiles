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

" Enter the current millenium
set nocompatible

" No swap and backup files
set noswapfile
set nobackup

" Enable syntax highliting and plugins
syntax enable
filetype plugin on

" Autotab for code
set autoindent

" Set relative and absolute line number
set relativenumber
set number

" Always show the status bar
set laststatus=2

" Search down into subfolders
set path=**

" Enhanced tab completion
set wildmenu wildmode=full

" Make backspace work
set backspace=indent,eol,start

" Use spaces instead of tabs. A tab equals to 4 spaces
" Hitting tab vim will inset four spaces. Also indent using four spaces
set tabstop=4 shiftwidth=4 expandtab smarttab

" Highlight all search results
set nohlsearch

" Do case insensitive search
set ignorecase

" Show incremental search results as you type
set incsearch

" Save before switching buffers and many other things
set autowriteall

" Don't wrap lines
set nowrap

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
let g:netrw_winsize = 15

" netrw disable banner
let g:netrw_banner = 0

" netrw tree starts from the current directory
" let g:netrw_keepdir = 0

" Set color scheme
colorscheme codedark

" ------------------------------------------------------------------------------
" STATUSLINE
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
" CUSTOM COMMANDS
" ------------------------------------------------------------------------------

" Source .vimrc in current directory if present
command -nargs=0 CmdLoadLocalConfig call CmdLoadLocalConfig()
function CmdLoadLocalConfig()
    if filereadable(".vimrc")
        source .vimrc
    endif
endfunction

" command -nargs=1 -complete=file CmdChangeDir call CmdChangeDir(<q-args>)
" function CmdChangeDir(path)
"     exe "cd " . a:path
"     call CmdLoadLocalConfig()
" endfunction

" ------------------------------------------------------------------------------
" AUTOMATICALLY LOAD LOCAL CONFIG AT STARTUP
" ------------------------------------------------------------------------------

call CmdLoadLocalConfig()

" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------

" Set <leader> to space
let mapleader = " "

" Open file explorer
nnoremap <leader>fe :Ex<cr>

" Quick edit and source .gvimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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

" Better quickfix
noremap <F9>  :copen<CR>
noremap <F10> :cn<CR>
noremap <F11> :cp<CR>
noremap <F12> :cclose<CR>

" -------------------------------------------------------------------------------
" C/C++ PROGRAMMING
" -------------------------------------------------------------------------------

" If on Windows map make program to build.bat script
if has("win32")
    set makeprg=build.bat

    function! CompileProject()
        silent make
        copen
    endfunction

    nnoremap <F1> :call CompileProject()<cr>
    nnoremap <F2> :cn<CR>
    nnoremap <F3> :cp<CR>
    nnoremap <F4> :cclose<CR>
endif

" ------------------------------------------------------------------------------
" AUTO COMMANDS
" ------------------------------------------------------------------------------

augroup vimrcgroup
    " Automatically open quickfix if there are matches
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow

    " Maximize on gui startup
    autocmd GUIEnter * simalt ~x

    " trim whitespaces on save
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" ------------------------------------------------------------------------------
