set nocompatible
filetype plugin on
" set tabwidth to 4 and use spaces
set tabstop=4 shiftwidth=4 expandtab

" This is using vim-plug to manage plugins
" https://github.com/junegunn/vim-plug
" To install:
" 1. put the plug in the block below
" 2. :source %    (This will source vimrc)
" 3. :PlugInstall
"
" To update plugins:
" :PlugUpdate
"
" To uninstall plugins:
" 1. Delete the plugin line from the block
" 2. :PlugClean
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/bash-support.vim'
Plug 'itchyny/lightline.vim'
call plug#end()

" Turn off the error and visual bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" enable syntax highlighting
syntax enable

" Show the line and column at the bottom of the vim window
set ruler

" Show line numbers
set number

" enable highlighting when searching
set hlsearch

" enable highlighting while typing search
set incsearch

" Show the tab line at the top of vim window
"set laststatus=2

" Only redraw when we need to
set lazyredraw

" Set the number of columns before word wrapping
set textwidth=120

set laststatus=2
