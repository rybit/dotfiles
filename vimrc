
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'
Plug 'edkolev/promptline.vim'

Plug 'chrisbra/csv.vim'

" python
Plug 'davidhalter/jedi-vim'
Plug 'andviro/flake8-vim'

" go
Plug 'fatih/vim-go'
Plug 'nsf/gocode'

" js
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'

" infrastructure
Plug 'hashivim/vim-terraform'
Plug 'pearofducks/ansible-vim'

if has('nvim')
  function! DoRemote(arg)
  	UpdateRemotePlugins
	endfunction
	Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
	Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'benekastah/neomake'
else
  Plug 'Shougo/neocomplete'
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
endif

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=" "

syntax on
colorscheme jellybeans
"colorscheme desert
"colorscheme hybrid

" the right hand margin
set colorcolumn=120
:hi colorcolumn ctermbg=grey

set encoding=utf8
set mouse=                      " disable the mouse

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/temp

set incsearch
set hlsearch                    " highlight the search term
set ignorecase
set smartcase

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents

set showmatch
set hidden
set number
set ruler
set wrap
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY REMAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDtree
map <c-t> :NERDTreeToggle<CR>

" Ctrl-P
nnoremap gm :CtrlPMixed<cr>
nnoremap gl :CtrlPLine<cr>
nnoremap gb :CtrlPBuffer<cr>
nnoremap go :CtrlP<cr>
nnoremap gr :CtrlPMRUFiles<cr>

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
nmap <leader>d :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" for easier splitting
nmap <leader>s :split<CR>
nmap <leader>v :vsplit<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk


map q: :q                    " Stop that popup from showing up
nnoremap <leader>w :w<CR>    " Save with <Space>w
nnoremap <leader>c :q<CR>    " Quit with <Space>q
nnoremap <leader>wq :wq<CR>  " Save and quit with <Space>wq

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
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quote a word consisting of letters from iskeyword.
vmap <silent> <leader>es :call Surround(''', ''')<CR>
vmap <silent> <leader>ed :call Surround('"', '"')<CR>
vmap <silent> <leader>et :call Surround('`', '`')<CR>
vmap <silent> <leader>eb :call Surround('[', ']')<CR>
vmap <silent> <leader>ep :call Surround('(', ')')<CR>
vmap <silent> <leader>ec :call Surround('{', '}')<CR>

function! Surround(opening, closing)
  let save = @"
  silent normal gvy
  let @" = a:opening . @" . a:closing
  silent normal gvp
  let @" = save
endfunction

"
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite * :call DeleteTrailingWS()

" Special formatting rules for certain types
autocmd BufRead,BufNewFile *.txt setlocal wrap linebreak nolist tw=120
autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 list listchars=tab:>·,trail:·

au FileType json nmap <leader>p :%!python -m json.tool

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" JEDI-VIM
let g:jedi#documentation_command = "K"
autocmd FileType python setlocal completeopt-=preview

" AIRLINE
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" TABULAR
let g:vim_markdown_folding_disabled = 1

" NEO COMPLETE
let g:deoplete#enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
set completeopt-=preview

" VIM-GO

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

au FileType go nmap <leader>gs <Plug>(go-def-split)
au FileType go nmap <leader>gv <Plug>(go-def-vertical)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>gb <Plug>(go-doc-browser)


" FLAKE8
let g:PyFlakeOnWrite = 0
let g:PyFlakeCheckers = 'pep8'

" let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeSigns = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NEOVIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
  tnoremap <Esc> <C-\><C-n>

  nnoremap <leader>y :vsp<cr> :terminal<cr>
  nnoremap <leader>t :sp<cr> :terminal<cr>

  autocmd! BufWritePost * Neomake
  nnoremap <leader>l :lopen<cr>
endif
