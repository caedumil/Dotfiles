" VIMRC
" Vim-Plug (https://github.com/junegunn/vim-plug) manages all plugins
"
" on new installation, run:
"   :PlugInstall

" VIM mode {{{
" Force 256 colors
set t_Co=256

" Disable VI compatibility mode
set nocompatible

" Use UTF-8
set encoding=utf-8

" Enable modeline
set modeline

" Look for modeline in the final line
set modelines=1
" }}}

" Vim Plug {{{
call plug#begin('~/.vim/plugged')

" Plugins on GitHub
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'kien/ctrlp.vim'
Plug 'embear/vim-localvimrc'

" Color schemes
Plug 'chriskempson/base16-vim'

" Add plugins to &runtimepath
call plug#end()
" }}}

" Misc {{{
" Leader is comma
let mapleader=","
" }}}

" Colors {{{
" Enable Syntax highlighting
syntax enable

" Set color scheme
set background=dark
let base16colorspace=256
colorscheme base16-ocean
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

" 80 char a line, no more!
set textwidth=80

" Mark the column after textwidth
set colorcolumn=+1

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
" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Highlight last inserted text
nnoremap gV `[v`]
" }}}

" Vim CtrlP {{{
" Settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrp_user_command = 'ag %s -l --nocolor -g ""'
" }}}

" Vim Airline {{{
set laststatus=2
set ttimeoutlen=50

let g:airline_theme='base16'
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline#extensions#tabline#enabled=1

let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message=''
" }}}

" Vim Syntastic {{{
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0

let g:syntastic_mode_map={
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" C++14
let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++14'
" }}}

" Vim LocalVimRC {{{
let g:localvimrc_name=[ '.lvimrc', '.vimrc.local' ]
" }}}

" Custom functions {{{
" Don't open command history
map q: :q

" Toggle relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction

" Strips trailing whitespaces.
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
