
" Reload configuration file
    " in .vimrc         ->  :source %
    " in another file   ->  :source ~/.vimrc
"""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""

"""""""""
" Vundle
"""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'

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
" vim-plug
""""""""""""

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" onedark colorscheme
Plug 'joshdick/onedark.vim'

" check syntax on each save
"Plug 'vim-syntastic/syntastic'

" NERDTree
Plug 'scrooloose/nerdtree'

" Emmet-vim
Plug 'mattn/emmet-vim'

" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  :CocInstall coc-html
"  :CocInstall coc-css
"  :CocInstall coc-tsserver

" vim-visual-multi
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

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
""""""""""""""""""""""""""""""""""

" Miscellaneous settings

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

"" enable search highlighting
"set hlsearch
" Search with no highlights
set nohlsearch

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
hi Normal guibg=NONE ctermbg=NONE
highlight LineNr ctermfg=24

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

" copy to system clipboard
set clipboard=unnamedplus

" remove random characters
set t_RV=
set t_u7=

" remap scrolling (up, down arrow)
noremap <Down> <C-E>
noremap <Up> <C-Y>

" keep cursor in center of screen
set so=999
" turn off cursor in center of screen with 'set so=0'

" go to last line with G and center screen to cursor
noremap G Gzz

" less escape delay
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

" Navigate up/down long lines with g+...
nnoremap j gj
nnoremap k gk

" turn off automatic YouCompleteMe cursor hover info
let g:ycm_auto_hover = ''
" toggle language hover info with F3
map <F3> <plug>(YCMHover)

" toggle YouCompleteMe on and off with F4
let g:ycm_auto_trigger = 0
function Toggle_ycm()
    if g:ycm_auto_trigger == 0
        let g:ycm_auto_trigger = 1
    elseif g:ycm_auto_trigger == 1
        let g:ycm_auto_trigger = 0
    endif
endfunction
map <F4> :call Toggle_ycm() <CR>

" toggle syntax checker in YouCompletMe
let g:ycm_show_diagnostics_ui = 0

" toggle spellchecker, previous, next (ctrl + s, a, d)
" toggle spellchecker, previous, next (ctrl + s, a, d)
map <C-s> :setlocal spell! spelllang=en_us<CR>
map <C-a> [s
map <C-d> ]s
" set global, local dictionary files
    " zg  ->  add to global file
    " 2zg ->  add to local file
    " zug  ->  remove from global
    " 2zug  ->  remove from local
setlocal spellfile+=~/.vim/spell/en.utf-8.add
setlocal spellfile+=.oneoff.utf-8.add

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

" set tabs to 2 for htm, html, yml files
autocmd BufRead,BufNewFile *.htm,*.html,*.yml,*.yaml,*.json setlocal tabstop=2 shiftwidth=2 softtabstop=2

" use interactive shell -> access to .bash_alias functions
set shellcmdflag=-ic

" rename window and pane on start, focus, write
autocmd BufWrite * call system("tmux rename-window ' " . expand("%:t") . " '")
autocmd BufWrite * call system("tmux select-pane -T ' " . expand("%:t") . " '")

" HTML boilerplate ( :Html )
command Html 0r ~/.vim/skeletons/main.html

" C boilerplate ( :C )
command C 0r ~/.vim/skeletons/base.c

" C++ boilerplate ( :Cpp )
command Cpp 0r ~/.vim/skeletons/base.cpp

" compile and run current C source file in new tmux pane
" delete compiled file
" compile, run (F5)
function C_compile()
    call system("tmux split-window -h -p 40")
    call system("tmux send-keys -t .1 'basedirRename' Enter")
    call system("tmux send-keys -t .1 clear Enter")
    call system("tmux send-keys -t .1 'gcd " . expand("%:t") . "' Enter")
    call system("tmux select-pane -t .0")
    :silent exec "!fileRename %"
    :redraw!
endfunction
noremap <F5> :call C_compile() <CR>

" compile and run current C++ source file in new tmux pane
" delete compiled file
" compile, run (F6)
function Cpp_compile()
    call system("tmux split-window -h -p 40")
    call system("tmux send-keys -t .1 'basedirRename' Enter")
    call system("tmux send-keys -t .1 clear Enter")
    call system("tmux send-keys -t .1 'c " . expand("%:t") . "' Enter")
    call system("tmux select-pane -t .0")
    :silent exec "!fileRename %"
    :redraw!
endfunction
noremap <F6> :call Cpp_compile() <CR>

" compile and run current Python source file in new tmux pane
" delete compiled file
" compile, run (F7)
function Py_compile()
    call system("tmux split-window -h -p 40")
    call system("tmux send-keys -t .1 'basedirRename' Enter")
    call system("tmux send-keys -t .1 clear Enter")
    call system("tmux send-keys -t .1 'pyd " . expand("%:t") . "' Enter")
    call system("tmux select-pane -t .0")
    :silent exec "!fileRename %"
    :redraw!
endfunction
noremap <F7> :call Py_compile() <CR>

" exit tmux compile pane (F8)
function Exit_compile()
    call system("tmux send-keys -t .1 C-c")
    call system("tmux send-keys -t .1 C-d")
    :silent exec "!fileRename %"
    :redraw!
endfunction
noremap <F8> :call Exit_compile() <CR>

" NERDTree settings
    " I == toggle h(I)dden file view
    " C == make selection (C)urrent working directory
    " U == go (U)p directory
" NERDTree toggle, (F2)
map <F2> :NERDTreeToggle<CR>
" make pwd the parent directory
let g:NERDTreeChDirMode=3

" Rename tmux window on save
" :help filename-modifiers
"if exists('$TMUX')
"    autocmd BufEnter,FocusGained,BufWrite * call system("tmux rename-window ' " . expand("%:t") . " '")
"    autocmd BufEnter,FocusGained,BufWrite * call system("tmux select-pane -T ' " . expand("%:t") . " '")
"    autocmd VimLeave * call system("tmux rename-window ' " . $BASEPATH . "/ '")
"    autocmd VimLeave * call system("tmux select-pane -T ' " . $BASEPATH . "/ '")
"endif

" scroll okular with foot pedal
"function Okul_up()
"    call system("xdotool search --class okular key --window %@ Up")
"endfunction
"function Okul_down()
"    call system("xdotool search --class okular key --window %@ Down")
"endfunction

"" disable math conceal in vim-markdown
"let g:tex_conceal = ""
"let g:vim_markdown_math = 1

"" vim-syntastic error checking shortcuts
"" check for errors (F3), close error list (F4)
"" set to passive mode 
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
"" check for errors (F3), return to normal mode (F4)
"" :redraw! == clear status line
"nnoremap <F3> :SyntasticCheck <CR> :Errors <CR> :redraw! <CR>
"nnoremap <F4> :SyntasticToggleMode <CR> :SyntasticToggleMode <CR> :redraw! <CR>
"" next/previous error (Ctrl + n,p)
"nnoremap <C-n> :lnext <CR> :redraw! <CR>
"nnoremap <C-p> :lprev <CR> :redraw! <CR>

