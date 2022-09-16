" VIMRC
"{{{
" on new installation:
"
"   mkdir -p ~/.config/nvim/pack/minpac/opt
"   cd ~/.config/nvim/pack/minpac/opt
"   git clone https://github.com/k-takata/minpac.git
"
" inside vim call install all packages
"
"   :call minpac#update()
"}}}

" Package Manager {{{
" minpac (https://github.com/k-takata/minpac) manages all packages
packadd minpac
call minpac#init()

" Make minpac manage itself
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Packages list
call minpac#add('itchyny/lightline.vim')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-endwise')
call minpac#add('bkad/CamelCaseMotion')
call minpac#add('arcticicestudio/nord-vim')
" }}}

" Backup {{{
" Store swap files in fixed location, not current directory
set directory=~/.config/nvim/tmp/swap
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p')
endif

" Enable persistent undo betweem sessions
set undodir=~/.config/nvim/tmp/undo
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif
set undofile

" Disable persistent undo for temporary files
augroup vimrc
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
"}}}

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

" Number of spaces for indent. '0' means 'tabstop' value.
set shiftwidth=0

" Indent line when pressing TAB
set smarttab

" Tabs are spaces
"set expandtab

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
set colorcolumn=100,120

" Show command in bottom bar
set showcmd

" Highlight current line
set cursorline

" Disable cursor-styling
set guicursor=

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

" Key mappings {{{
" Leader is comma
"let mapleader=","

" Move vertically by visual line, even with 'relativenumber' set
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Highlight last inserted text
nnoremap gV `[v`]

" Make 'Y' yank everything from cursor to end of line
noremap Y y$
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
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ }
" }}}

" Vim CamelCaseMotion {{{
let g:camelcasemotion_key = '<leader>'
" }}}

" Tweaks {{{
" Don't open command history
map q: :q

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
" nnoremap <leader>w :call StripWhitespaces()<CR>
function! StripWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" vim:foldmethod=marker:foldlevel=0
