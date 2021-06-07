
""""""""""""""""""""""""""""""""""""""""""
"Vundle settings

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" check syntax on each save
Plugin 'vim-syntastic/syntastic'

" NERDTree
Plugin 'scrooloose/nerdtree'

" OneDark color scheme 
Plugin 'joshdick/onedark.vim'

" glench/vim-jinja2-syntax
Plugin 'glench/vim-jinja2-syntax'


" INSTALL PLUGINS with:   
    "  :source %
    "  :PluginInstall
" DELETE PLUGINS
    " delete Plugin line above
    " :PluginUpdate


" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""""""
" Miscellaneous settings

" show line numbers
set number

" new lines inherit indentation of previous lines
set autoindent

" round indentation to nearest multiple of shiftwidth when shifting lines
set shiftround

" indent 4 spaces when shifting
set shiftwidth=4

" insert tabstop number of spaces when tab is pressed
set tabstop=4

" convert tabs to spaces, backspace removes tab
set softtabstop=4 expandtab

" set tabs to 2 for htm, html, yml files
autocmd BufRead,BufNewFile *.htm,*.html,*.yml setlocal tabstop=2 shiftwidth=2 softtabstop=2

" ignore case when searching
set ignorecase

" enable search highlighting
set hlsearch

" incremental search that shows partial matches
set incsearch

" auto switch search to case-sensitive when search query contains an uppercase letter
set smartcase

" avoid wrapping line in middle of word
set linebreak

" enable syntax highlighting
syntax on

" set colorscheme
colorscheme onedark

" always show cursor position
set ruler

" display command line's tab complete options as menu
set wildmenu

" disable error beeps, flash screen instead
set noerrorbells
" set visualbell

" enable mouse for scrolling and resizing
set mouse=a

" window title for current file
set title

" allow backspacing over indentation, line breaks, insertion start
set backspace=indent,eol,start

" confirmation dialogue before closing unsaved file
set confirm

" increase history limit
set history=1000

" NERDTree toggle, <F2>
map <F2> :NERDTreeToggle<CR>

" copy to system clipboard
set clipboard=unnamedplus

" set tab title to filename in tmux
"autocmd BufEnter * call system("tmux rename-window \\\\\\\\" . expand("%:t"))
"autocmd VimLeave * call system("tmux rename-window bash")
autocmd VimEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux source-file ~/.tmux.conf")

" Reselect visual mode selection for indenting
vnoremap < <gv
vnoremap > >gv

" Preserve copied data when replacing with visual mode
xnoremap <expr> p '"_d"'.v:register.'p'

" Search with no highlights
set nohlsearch

" Navigate up/down long lines with g+...
nnoremap j gj
nnoremap k gk

