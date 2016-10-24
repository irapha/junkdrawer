set nocompatible              " turn VIMproved features on
filetype off                  " required

""" VUNDLE
" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins:
"   call vundle#begin('~/some/path/here')
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Brief help (see :h vundle for more details or wiki for FAQ)
"   :PluginList       - lists configured plugins
"   :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"   :PluginSearch foo - searches for foo; append `!` to refresh local cache
"   :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

Plugin 'gmarik/Vundle.vim'                    " let Vundle manage Vundle
Plugin 'wincent/command-t'                    " Fast file navigation.
Plugin 'luochen1990/rainbow'                  " Rainbow parenthesis
Plugin 'Valloric/YouCompleteMe'               " Autocompletion.
Plugin 'scrooloose/nerdtree'                  " Easy file navigation within vim.
Plugin 'Xuyuanp/nerdtree-git-plugin'         " Git diffs in nerdtree files
Plugin 'tpope/vim-surround'           " editing surrounding quotes, parens, etc.
Plugin 'scrooloose/syntastic'         " Syntax checking and highlighting
Plugin 'Yggdroot/indentLine'                  " Display indentation line markers
Plugin 'easymotion/vim-easymotion'            " Easy navigation infile
Plugin 'haya14busa/incsearch.vim'             " Incremental search
Plugin 'haya14busa/incsearch-easymotion.vim'  " IncSearch + EasyMotion integration
Plugin 'dart-lang/dart-vim-plugin'            " Dart lang syntax highlighting.

" Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'} " Power status line
" Plugin 'L9' " Useful vim functions. From http://vim-scripts.org/vim/scripts.html
" Plugin 'tpope/vim-fugitive'                   " Git commands within vim
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'} " Shortcuts for HTML scripting.
call vundle#end()

filetype plugin indent on    " required for Vundle
" To ignore plugin indent changes, instead use:
"   filetype plugin on
""" VUNDLE END

""" THEMES
" Solarized colorscheme (light version)
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" JellyBeans colorscheme
" set background=dark
" colorscheme jellybeans

" Smyck colorscheme
" colorscheme smyck

" Tomorrow Night Eighties colorscheme
colorscheme tomorrow-night-eighties

" Material color scheme.
" set background=dark
" colorscheme material
""" THEMES END

" mapleader to ,
" useful for running leader commands
"   ,c<space> to toggle comment (NERDCommenter command)
"   ,ca to change what delimiters to use (NERDCommenter command)
"   ,<space> is :nohlsearch<CR> (defined below)
:let mapleader = ","

" Fix Backspace to be able to delete things not in current insert session.
set backspace=indent,eol,start

set nu                                " show line numbers.
set cursorline                        " highlight current line.
highlight Cursorline cterm=bold ctermbg=Black " set line highlighting options
set wildmenu                          " visual autocomplete for command menu
set pastetoggle=<F2>      " enter paste mode (:set paste / :set nopaste)
syntax enable                         " Enable syntax
set encoding=utf-8                    " encoding uft-8
set tabstop=2                         " number of visual spaces per TAB char
set softtabstop=2         " number of spaces a TAB counts for when editing
set shiftwidth=2          " number of spaces used when indenting with >> and <<
set expandtab                         " makes TAB = spaces.
inoremap jk <ESC>|                    " Map jk to esc
cmap w!! w !sudo tee % >/dev/null|    " :w!! to write with sudo.
:2mat ErrorMsg '\%>80v.'              " Highlight character after cell 81.
let g:rainbow_active = 1              " Allow rainbow parenthesis plugin

" EASYMOTION settings
nmap s <Plug>(easymotion-s)|          " Search for given char (sa highlights 'a')
map <Leader>j <Plug>(easymotion-j)|   " Highlight every line down
map <Leader>k <Plug>(easymotion-k)|   " Highlight every line up

" The command below are not used because incsearch uses them instead.
" If you remove IncSearch, also uncomment these, and remove IncSearch+EasyMotion
" map / <Plug>(easymotion-sn)|          " Remaps / to search with easymotion
" omap / <Plug>(easymotion-tn)|         "   Same as above
" map n <Plug>(easymotion-next)|        "   jump to next match in search
" map N <Plug>(easymotion-prev)|        "   jump to prev match in search
" EASYMOTION END

" IncSearch Start
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" IncSearch End

" IncSearch + EasyMotion Start
map / <Plug>(incsearch-easymotion-/)| " Remaps / to seach with incsearch+easymotion
omap / <Plug>(incsearch-easymotion-/)|"   Same as above
" IncSearch + EasyMotion End

" Searching 
set incsearch " search as characters are entered
set hlsearch " highlight matches
nnoremap <leader><space> :nohlsearch<CR>|   " turn off search highlight

""" NERDTree / NERDCommenter settings.
" Close vim if the only window still open is NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Use Control + n to toggle NERDTree.
:map <C-n> :NERDTreeToggle<CR>
" Use <leader> + n to toggle NERDTree.
:map <leader>n :NERDTreeToggle<CR>
" use space delims when toggling comments in NERDCommenter
:let NERDSpaceDelims = 1
""" NERD settings END

""" POWERLINE VIM STATUS
" set laststatus=2|                     " Always show status line
" noshowmode                " Hide default mode text (like __INSERT__)
""" POWERLINE END

" Trim whitespace when closing file.
function! <SID>StripTrailingWhitespaces()
  let _s=@/            
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e   
  let @/=_s            
  call cursor(l, c)
endfunction            
autocmd BufWritePre *.rb,*.py,*.js :call <SID>StripTrailingWhitespaces()

""" TERMINAL.APP CURSOR HACK
" If this is Terminal.app, do cursor hack for visible cursor
" This hack does not behave well with other terminals (particularly xterm)
" Also add `setenv ORIGTERM $TERM` to ~/.screenrc
function MacOSX()
  hi CursorLine term=none cterm=none "Invisible CursorLine
  set cursorline "cursorline required to continuously update cursor position
  hi Cursor cterm=reverse "I like a reversed cursor, edit this to your liking
  match Cursor /\%#/ "This line does all the work
endfunction

if $TERM_PROGRAM == "Apple_Terminal" " Terminal.app, xterm and urxvt pass this test
 if $WINDOWID == ""                  " xterm and urxvt don't pass this test
  "It is unlikely that anything except Terminal.app will get here
  call MacOSX()
 endif
endif

if $SSH_TTY != ""            " If the user is connected through ssh
 if $TERM == "xterm-color" || $ORIGTERM = "xterm-color"
  "Something other than Terminal.app might well get here
  call MacOSX()
 endif
endif
""" TERMINAL.APP CURSOR HACK END
