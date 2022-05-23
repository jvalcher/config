
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

" tabular  (for vim-markdown)
Plugin 'godlygeek/tabular'

" vim-markdown
Plugin 'preservim/vim-markdown'

" YouCompletMe
Plugin 'ycm-core/YouCompleteMe'

" CSS color value highlighting
Plugin 'ap/vim-css-color'


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

" Automatically show Vim's autocomplete menu
Plug 'vim-scripts/AutoComplPop'

" OnSyntaxChange  (disable AutoComplPop inside comments)
Plug 'vim-scripts/OnSyntaxChange'

"Goyo
"Plug 'junegunn/goyo.vim'

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


""Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
""If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"
"if (empty($TMUX))
"    if (has("nvim"))
"        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"    endif
"        "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"        "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"        " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"    if (has("termguicolors"))
"        set termguicolors
"    endif
"endif


""""""""""""""""
" Color scheme "
""""""""""""""""

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" fixes glitch(?) in colors when using vim with tmux
set background=dark
set t_Co=256

set term=xterm-256color
set termguicolors

" set color scheme
silent! colorscheme onedark

" show line numbers
set number

" change line number color  (not working)
highlight LineNr ctermfg=24



""""""""""""""""""""""""""
" Miscellaneous settings "
""""""""""""""""""""""""""


" new lines inherit indentation of previous lines
set autoindent

" round indentation to nearest multiple of shiftwidth when shifting lines
set shiftround

" insert tabstop number of spaces when tab is pressed
set tabstop=4

" indent n spaces when shifting
set shiftwidth=4

" convert tabs to spaces, backspace removes tab
set softtabstop=4 expandtab

" toggle tabs between 4 and 8  <F7>
let tab_var=4 
function Toggle_tab()
    if g:tab_var == 4
        :setlocal tabstop=8 shiftwidth=8 softtabstop=8
        :let g:tab_var = 8
        :echo "tabs 8"
    elseif g:tab_var == 8
        :setlocal tabstop=4 shiftwidth=4 softtabstop=4
        :let g:tab_var = 4
        :echo "tabs 4"
    endif
endfunction
map <F7> :call Toggle_tab() <CR>

" set tabs to 2 for htm, html, yml, yaml, json files
autocmd BufRead,BufNewFile *.htm,*.html,*.yml,*.yaml,*.json setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Search with no highlights
set nohlsearch
"set hlsearch

" stop search at end of file
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

" always show cursor position
set ruler

" display command line's tab complete options as menu
set wildmenu

" disable error beeps
set noerrorbells

" enable mouse for scrolling and resizing
set mouse=a
map <ScrollWheelDown> gj
map <ScrollWheelUp> gk

" allow backspacing over indentation, line breaks
set backspace=indent,eol,start

" disable automatically wrapping comments and inserting lead quotation mark with <Enter> and <o,O> on newlines
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" show confirmation dialogue before closing unsaved file
set confirm

" toggle paste, nopaste  <F5>
function! Toggle_paste()
    :set paste!
    :set paste?
endfunction
map <F5> :call Toggle_paste() <CR>

" increase history limit
set history=1000

" copy to system clipboard
set clipboard=unnamedplus

" remap scrolling to up, down arrow
"noremap <Down> <C-E>
"noremap <Up> <C-Y>

" toggle keeping cursor vertically centered on screen  <F8>
autocmd CursorMoved,CursorMovedI * call Center_cursor()
function! Center_cursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction
let s:center=1
function Toggle_center_cursor()
    if s:center
        autocmd! CursorMoved,CursorMovedI *
        let s:center=0
        echo "Cursor free"
    else
        autocmd CursorMoved,CursorMovedI * call Center_cursor()
        let s:center=1
        echo "Cursor center"
    endif
endfunction
map <F8> :call Toggle_center_cursor() <CR>

" navigate wrapped lines
nnoremap j gj
nnoremap k gk

" center screen to cursor when jumping to last line with G
nnoremap G Gzz

" less escape key delay
set timeout timeoutlen=50

" navigate vim panes  <ctrl+w + h,j,k,l>
nnoremap <C-W><J> <C-W><C-J>
nnoremap <C-W><K> <C-W><C-K>
nnoremap <C-W><L> <C-W><C-L>
nnoremap <C-W><H> <C-W><C-H>

" reselect visual block for multiple indents
vnoremap < <gv
vnoremap > >gv

" Preserve copied data when replacing with visual mode
xnoremap <expr> p '"_d"'.v:register.'p'

" disable vim-markdown concealing (enable -> 2)
set conceallevel=0

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled = 1

" unmap K (exits vim to man page for term under cursor)
nnoremap K <Nop>

" set persistent undo, target directory
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

""WSL yank to clipboard
"let s:clip = '/mnt/c/Windows/System32/clip.exe'
"if executable(s:clip)
"    augroup WSLYank
"        autocmd!
"        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"    augroup END
"endif

"Toggle YouCompleteMe  <F3>
let g:ycm_auto_trigger = 1
let g:ycm_show_diagnostics_ui = 1
function Toggle_ycm()
    if g:ycm_show_diagnostics_ui == 0
        let g:ycm_auto_trigger = 1
        let g:ycm_show_diagnostics_ui = 1
		:YcmRestartServer
		:e
		:echo "YCM on"
    elseif g:ycm_show_diagnostics_ui == 1
        let g:ycm_auto_trigger = 0
        let g:ycm_show_diagnostics_ui = 0
		:YcmRestartServer
		:e
		:echo "YCM off"
    endif
endfunction
map <F3> :call Toggle_ycm() <CR>

"Toggle YouCompletMe language hover info <F4>
let g:ycm_auto_hover=""
map <F4> <plug>(YCMHover)

" Turn off YouCompleteMe for html, css, js files
autocmd BufRead,BufNewFile *.htm,*.html,*.css,*.js
\ let g:ycm_auto_trigger=0 |
\ let g:ycm_show_diagnostics_ui=0

" enable Vim's builtin html, css, js autocompletion
autocmd BufRead,BufNewFile *.css            set omnifunc=csscomplete#CompleteCSS
autocmd BufRead,BufNewFile *.htm,*.html     set omnifunc=htmlcomplete#CompleteTags
autocmd BufRead,BufNewFile *.js             set omnifunc=javascriptcomplete#CompleteJS

" only load vim-css-color for css files
    " must disable the following call in .vim/bundle/autoload/css_color.vim
autocmd BufRead,BufNewFile *.css call css_color#enable()

" disable AutoComplPop inside comments
call OnSyntaxChange#Install('Comment', '^Comment$', 0, 'i')
autocmd User SyntaxCommentEnterI silent! AcpLock
autocmd User SyntaxCommentLeaveI silent! AcpUnlock

" use interactive shell in order to access .bash_aliases functions
"set shellcmdflag=-ic
" rename tmux window and pane to filename when saving with fileRename() from .bash_aliases
"if exists('$TMUX')
"    autocmd BufWrite * :silent exec "!fileRename %" | :redraw!
"endif

" NERDTree settings
    " I == toggle h(I)dden file view
    " C == make selection (C)urrent working directory
    " U == go (U)p directory
" open/close NERDTree <F2>
map <F2> :NERDTreeToggle<CR>
" make pwd the parent directory
let g:NERDTreeChDirMode=3
" close menu after opening file
let NERDTreeQuitOnOpen=1


"""""""""""""""
" Boilerplate "
"""""""""""""""

" Bash boilerplate ( :Bash )
command Bash 0r ~/.vim/skeletons/bash
" C boilerplate ( :C )
command C 0r ~/.vim/skeletons/c
" C debug macros ( :Cd )
command Cd 0r ~/.vim/skeletons/c_debug
" C++ boilerplate ( :Cpp )
command Cpp 0r ~/.vim/skeletons/cpp
" HTML boilerplate ( :Html )
command Html 0r ~/.vim/skeletons/html
" CSS boilerplate ( :Css )
command Css 0r ~/.vim/skeletons/css

