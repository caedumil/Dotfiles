" VIMRC
" Vim-Plug (https://github.com/junegunn/vim-plug) manages all plugins
"{{{
" on new installation, download plug.vim:
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" then open vim and run:
"
"   :PlugInstall
"}}}

" VIM mode {{{
" Force 256 colors
"set t_Co=256

" Disable VI compatibility mode
set nocompatible

" Use UTF-8
set encoding=utf-8

" Enable modeline
set modeline

" Look for modeline in the final line
set modelines=1

" Set a POSIX shell if needed
if &shell =~# 'fish$'
    set shell=/bin/bash
endif
" }}}

" Vim Plug {{{
call plug#begin('~/.vim/plugged')

" Plugins on GitHub
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'majutsushi/tagbar'            " requires ctags

" Syntax highlighters
Plug 'dag/vim-fish'

" Color schemes
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'
Plug 'arcticicestudio/nord-vim'

" Add plugins to &runtimepath
call plug#end()
" }}}

" Backup {{{
" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

" Store swap files in fixed location, not current directory
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=~/.vim/swap//

" Allows you to use undos after exiting and restarting
if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=~/.vim/undo//
set undofile
"}}}

" Misc {{{
" Leader is comma
let mapleader=","
" }}}

" Colors {{{
" Enable Syntax highlighting
syntax enable

" Set background mode
set background=dark

" Set color mode
colorscheme nord
" }}}

" Spaces & Tabs {{{
" Number of visual spaces per TAB
set tabstop=4

" Number of spaces in tab when editing
set softtabstop=4

" Number of spaces for indent
set shiftwidth=4

" Indent line when pressing TAB
set smarttab

" Tabs are spaces
set expandtab

" Auto indent
set smartindent

" Use to see the difference between tabs and spaces
set list

" Customize characters to use in list mode
set listchars=trail:·,tab:»·,eol:¬
" }}}

" UI Config {{{
" Show line numbers
set number

" Max width of text. Longer line will be broken after white space.
set textwidth=0

" Comma separated list of screen columns that are highloghted.
" Can be an absolute number, or a number preceded with '+' or '-', which is
" added to or substracted from 'textwidth'.
set colorcolumn=80,100

" Show command in bottom bar
set showcmd

" Highlight current line
set cursorline

" Load filetype-specific indent files
filetype indent on

" Visual autocomplete for command menu
set wildmenu

" Redraw only when needed to
set lazyredraw

" Highlight matching [{()}]
set showmatch
" }}}

" Searching {{{
" Search as characters are entered
set incsearch

" Case insensitive
set ignorecase

" Highlight matches
set hlsearch

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Folding {{{
" Enable folding
set foldenable

" Open most folds by default
set foldlevelstart=10

" 10 nested fold max
set foldnestmax=10

" space open/close folds
"nnoremap <space> za

" Fold based on indent level
set foldmethod=indent
" }}}

" Movement {{{
" Move vertically by visual line, even with 'relativenumber' set
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Highlight last inserted text
nnoremap gV `[v`]
" }}}

" Vim Lightline {{{
" Always show statusline
set laststatus=2

" Show mode only on statusline
set noshowmode

" Lightline config
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }
" }}}

" Vim Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1

let g:syntastic_mode_map={
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" C++14
let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++14'
" }}}

" Vim TagBar {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" Custom functions & mappings {{{
" Don't open command history
map q: :q

" Make 'Y' yank everything from cursor to end of line
noremap Y y$

" Toggle relativenumber
nnoremap <leader>l :call ToggleNumber()<CR>
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction

" Strips trailing whitespaces.
nnoremap <leader>w :call <SID>StripWhitespaces()<CR>
function! <SID>StripWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0
