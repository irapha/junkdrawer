packadd! dracula
syntax enable
colorscheme dracula
set termguicolors

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
set encoding=utf-8                    " encoding uft-8
set tabstop=2                         " number of visual spaces per TAB char
set softtabstop=2         " number of spaces a TAB counts for when editing
set shiftwidth=2          " number of spaces used when indenting with >> and <<
set expandtab                         " makes TAB = spaces.
inoremap jk <ESC>|                    " Map jk to esc
cmap w!! w !sudo tee % >/dev/null|    " :w!! to write with sudo.
:2mat ErrorMsg '\%>80v.'              " Highlight character after cell 81.
" set colorcolumn=81
let g:rainbow_active = 1              " Allow rainbow parenthesis plugin
" set viminfo='20,<1000|                " Allow up to 1000 lines in copy buffer
set viminfo='100,<1000,s100,h
" these options below were necessary for nvim...
set laststatus=0|                     " Never show status line
set guicursor=n-v-c:block-Cursor      " always use block cursor
set guicursor+=i:block-Cursor         " always use block cursor

filetype plugin indent on

" Searching
set incsearch " search as characters are entered
set hlsearch " highlight matches
nnoremap <leader><space> :nohlsearch<CR>|   " turn off search highlight

" use space delims when toggling comments in NERDCommenter
:let NERDSpaceDelims = 1

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

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
