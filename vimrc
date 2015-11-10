
" VUNDLE "
set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
"Plugin 'ervandew/supertab'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'chrisbra/csv.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'davidhalter/jedi-vim'
"Plugin 'valloric/YouCompleteMe'
Plugin 'andviro/flake8-vim'
"Plugin 'chriskempson/base16-vim'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on    " required

syntax on
"colorscheme desert
"colorscheme jellybeans
colorscheme hybrid

" color columns 120+
"execute "set colorcolumn=" . join(range(120,335), ',')
set colorcolumn=120
:hi colorcolumn ctermbg=grey

set encoding=utf8
set t_Co=256                    " use 256 colors
set mouse=

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/temp

set hlsearch                    " highlight the search term
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents

set showmatch
set incsearch
set hidden
set number
set ruler
set wrap
set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice
set wildignore=*.o,*~,*.pyc,*.egg-info
set nostartofline               " leave my cursor position alone!
set lazyredraw
set noerrorbells
set shell=bash

if maparg('<C-L>', 'n')==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite * :call DeleteTrailingWS()

" stupid common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

" NERDtree
map <c-t> :NERDTreeToggle<CR>

" jedi-vim
let g:jedi#documentation_command = "K"
autocmd FileType python setlocal completeopt-=preview

" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <C-t> :enew<cr>

" Move to the next buffer
nmap <C-l> :bnext<CR>

" Move to the previous buffer
nmap <C-h> :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Special formatting rules for certain types
autocmd BufRead,BufNewFile *.txt setlocal wrap linebreak nolist tw=120
autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

" flake8
let g:PyFlakeOnWrite = 0
let g:PyFlakeCheckers = 'pep8'

" let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeSigns = 1

fun! s:ToggleMouse()
  if !exists("s:old_mouse")
    let s:old_mouse = "a"
  endif

  if &mouse == ""
    let &mouse = s:old_mouse
    echo "Mouse is for Vim (" . &mouse . ")"
  else
    let s:old_mouse = &mouse
    let &mouse=""
    echo "Mouse is for terminal"
  endif
endfunction
