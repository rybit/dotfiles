
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
"Plugin 'scrooloose/syntastic'
Plugin 'chrisbra/csv.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'davidhalter/jedi-vim'

call vundle#end()
filetype plugin indent on    " required

syntax on
colorscheme desert

" color columns 120+
execute "set colorcolumn=" . join(range(120,335), ',')
:hi ColorColumn ctermbg=234

set encoding=utf8
set mouse=

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/temp

set hlsearch                    " highlight the search term
set tabstop=4
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents
set expandtab                   " expand <Tab>s with spaces; death to tabs!


set showmatch
set incsearch
set hidden
set number
set ruler
set wrap
set list 
set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice
set wildignore=*.o,*~,*.pyc
set nostartofline               " leave my cursor position alone!

set lazyredraw

set noerrorbells
set shell=bash

" spelling
if v:version >= 700
  " Enable spell check for text files
  autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en
endif

"nnoremap <C-m> :set mouse=a<CR>
"nnoremap <C-M> :set mouse=<CR>

:command WQ wq
:command Wq wq
:command W w
:command Q q

" NERDtree
map <C-n> :NERDTreeToggle<CR>

" jedi-vim
let g:jedi#documentation_command = "K"
autocmd FileType python setlocal completeopt-=preview

" airline
let g:airline#extensions#tabline#enabled = 1

nnoremap <C-Left> :tabprev<CR>
nnoremap <C-Right> :tabnext<CR>
"nnoremap <C-t> :tabnew
"nnoremap <C-[> :tabprev<CR>
"nnoremap <C-]> :tabnext<CR>
nnoremap <C--> :vertical res -5
nnoremap <C-+> :vertical res +5

" tabs
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

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

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
