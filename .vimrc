syntax on
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
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

nnoremap <leader>vv :vsplit $MYVIMRC <cr> “ Edit ~/.vimrc
nnoremap <leader>vr :source $MYVIMRC <cr> “ Source ~/.vimrc

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
