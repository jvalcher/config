
" Reload configuration file
    " in .vimrc         ->  :source %
    " in another file   ->  :source ~/.vimrc
"""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""


""""""""""
" Vundle "
""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

""""""""""""""""""""
" Plugin directory: -->    ~/.vim/bundle/
""""""""""""""""""""

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


    
""""""""""""
" vim-plug "
""""""""""""

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" onedark colorscheme
Plug 'joshdick/onedark.vim'

" NERDTree
Plug 'scrooloose/nerdtree'

" INSTALL PLUGINS with:   
    "  :source %
    "  :PlugInstall
" OTHER
    "  :PlugUpdate  [name]
    "  :PlugClean
    "  :PlugUpgrade
    "  :PlugStatus
    "  :PlugDiff
    "  :PlugSnapshot[!] [output_path]

" Initialize plugin system
call plug#end()

""""""""""""""""""
""""""""""""""""""


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
        "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
        "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
        " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif



"""""""""""""""""""""""""""""""""
" Miscellaneous settings
""""""""""""""""""""""""""""""""""


" new lines inherit indentation of previous lines
set autoindent

" round indentation to nearest multiple of shiftwidth when shifting lines
set shiftround

" indent 4 spaces when shifting
set shiftwidth=4

" insert tabstop number of spaces when tab is pressed
set tabstop=4

" set tabs to 2 for htm, html, yml, yaml, json files
autocmd BufRead,BufNewFile *.htm,*.html,*.yml,*.yaml,*.json setlocal tabstop=2 shiftwidth=2 softtabstop=2

" convert tabs to spaces, backspace removes tab
set softtabstop=4 expandtab

" Search with no highlights
set nohlsearch
"set hlsearch

" stop incremental search at EOF
set nowrapscan

" jump to last position when opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" incremental search that shows partial matches
set incsearch

" ignore case when searching
set ignorecase

" auto switch search to case-sensitive when search query contains an uppercase letter
set smartcase

" enable autoread to reload files (load language theme for new source files)
set autoread
au FocusGained,BufEnter * :redraw!

" avoid wrapping line in middle of word
set linebreak

" enable syntax highlighting
syntax on

" show line numbers
set number

" set color scheme
silent! colorscheme onedark

" change line number color
highlight LineNr ctermfg=24

" always show cursor position
set ruler

" display command line's tab complete options as menu
set wildmenu

" disable error beeps, flash screen instead
set noerrorbells

" enable mouse for scrolling and resizing
set mouse=a

" allow backspacing over indentation, line breaks, insertion start
" to preserve source spacing when pasting multiple lines use 'set paste'
set backspace=indent,eol,start

" confirmation dialogue before closing unsaved file
set confirm

" increase history limit
set history=1000

" copy to system clipboard
set clipboard=unnamedplus

" remap scrolling to up, down arrow
noremap <Down> <C-E>
noremap <Up> <C-Y>

" keep cursor in center of screen
set so=999
"set so=0

" center screen to cursor when going to last line with G
noremap G Gzz

" less escape key delay
set timeout timeoutlen=50

" navigate vim panes (ctrl+w + h,j,k,l)
nnoremap <C-W><J> <C-W><C-J>
nnoremap <C-W><K> <C-W><C-K>
nnoremap <C-W><L> <C-W><C-L>
nnoremap <C-W><H> <C-W><C-H>

" Reselect visual block for multiple indents
vnoremap < <gv
vnoremap > >gv

" Preserve copied data when replacing with visual mode
xnoremap <expr> p '"_d"'.v:register.'p'

" Navigate up/down long lines with j, k
nnoremap j gj
nnoremap k gk

" enable vim-markdown concealing
set conceallevel=2

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled = 1

" set persistent undo, target directory
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

" use interactive shell -> access to .bash_alias functions
set shellcmdflag=-ic

" open 40% pane to right (F5)
function Tmux_split()
    call system("tmux split-window -h -p 40")
    call system("tmux send-keys -t .1 'tmux select-pane -t .0 -T " . expand("%:t") . "' Enter")
    call system("tmux send-keys -t .1 clear Enter")
endfunction
noremap <F5> :call Tmux_split() <CR>

" close pane to right (F6)
function Exit_pane()
    call system("tmux send-keys -t .1 C-c")
    call system("tmux send-keys -t .1 C-d")
    call system("tmux select-pane -t .0 -T ' " . expand("%:t") . " '")
endfunction
noremap <F6> :call Exit_pane() <CR>

" rename tmux window and pane on save with .bash_aliases function
autocmd BufWrite * :silent exec "!fileRename %" | :redraw!

" HTML boilerplate ( :Html )
command Html 0r ~/.vim/skeletons/main.html

" C boilerplate ( :C )
command C 0r ~/.vim/skeletons/base.c

" C++ boilerplate ( :Cpp )
command Cpp 0r ~/.vim/skeletons/base.cpp

" NERDTree settings
    " I == toggle h(I)dden file view
    " C == make selection (C)urrent working directory
    " U == go (U)p directory
" NERDTree toggle, (F2)
map <F2> :NERDTreeToggle<CR>
" make pwd the parent directory
let g:NERDTreeChDirMode=3

