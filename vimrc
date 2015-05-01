"""
" File ./.vimrc
"
" Quick notes:
"   F6 toggles spellcheck
"   F5 toggles paste mode
"
"""

" Load vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree.git'

call vundle#end()
" Now we can turn our filetype functionality back on
filetype plugin indent on

let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" NERDTree
map <C-k> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

" Coloring is good -- requires terminal theme suport
" color solarized
:syntax on

" Enable file type detection
:filetype plugin indent on

" Tabs to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" autoindent
set autoindent

" Highlight current line
set cursorline

" toggle pasting to deal with autoindent
set pastetoggle=<F5>

" cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" enable mouse support
set mouse=a

" line numbers
set number

" searching - ignore co<F6>ase and AI
set ignorecase
set smartcase

" toggle spelling with F4 key
map <F6> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

" beeps are annoying
set visualbell

" Search
set hlsearch

" Title
set title

" Ruler
set ruler

" Always show status line
set laststatus=2

" Strip trailing whitespace (F7)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
map <F7> :call StripWhitespace()<CR>
