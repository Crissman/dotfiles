syntax on
set clipboard=unnamed
setlocal spell spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set ignorecase
set smartcase
hi clear SpellBad
hi SpellBad cterm=underline
set linebreak
set relativenumber
set number
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

" nnoremap <SPACE> <Nop> " Doesn't work
let mapleader = '\'

set gdefault
set incsearch
set showmatch
set hlsearch

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-fugitive'
Plugin 'klen/python-mode', { 'branch': 'develop' }
Plugin 'tmhedberg/simpylfold'


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

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

nnoremap <leader>ev :vsplit $MYVIMRC <cr>  " Edit ~/.vimrc
nnoremap <leader>rv :so $MYVIMRC <cr>  " Source ~/.vimrc
map <silent> <leader>pd Oimport pdb; pdb.set_trace()<esc> " Add python debugging line
 
" Add fzf capabilities to VIM
set rtp+=/usr/local/opt/fzf

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap ; :

au FocusLost * :wa  " Save on loss of focus

autocmd FileType python normal zR
