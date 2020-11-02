
" Author: Mikus Riekstins (mikus.riekstins@gmail.com)

" ------------------------------------------------------------
" Plugins
" ------------------------------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim.git'
Plugin 'tpope/vim-surround'
Plugin 'itchyny/lightline.vim'

" Syntax plugins
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'elzr/vim-json'
Plugin 'cakebaker/scss-syntax.vim'

call vundle#end()

" CtrlP ignore files and folders
 let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|DS_Store\|git'

" Emmet shortcut remap
 let g:user_emmet_leader_key='<C-Z>'

" ------------------------------------------------------------
" General
" ------------------------------------------------------------

set nocompatible                " Use Vim instead of Vi setting
set backspace=indent,eol,start  " Make backspace behave normaly
filetype plugin indent on       " Enable file type detection
syntax enable                   " Enable syntax highlighting on
set nobackup                    " Disable use of backups
set nowritebackup               " Disable writing to backups
set noswapfile                  " Disable swap files
set hidden                      " Enable switching buffers w/o saving
set t_Co=256                    " Set 256 colors

" ------------------------------------------------------------
" Movement
" ------------------------------------------------------------


set scrolloff=3                 " Cursor offset for scrolling

" ------------------------------------------------------------
" User Interface
" ------------------------------------------------------------

set number                      " Line numbers
set numberwidth=5               " Make space for at least 4
set laststatus=2                " Always show status line
set background=dark             " Dark variation of colorscheme
colorscheme lucy                 " Set colorscheme
set splitbelow                  " H-Split to bottom
set splitright                  " V-Split to right
set cursorline                  " Highlighted current line
set linespace=8                 " Set line height
set rnu                         " Relative line numbers
set cc=80                       " Color column 80
set list                        " Show hidden characters
set listchars=trail:~           " Set hidden characters

" ------------------------------------------------------------
" Formating
" ------------------------------------------------------------

set tabstop=2                   " Size of tabs
set shiftwidth=2                " Size of an indent
set softtabstop=2               " Soft tab size
set smarttab                    " Tab insterts indents for new line
set expandtab                   " Always use spaces instead of tab
set nowrap                      " Do not wrap lines
set textwidth=0                 " Do not limit text width
set autoindent                  " Enable autoindent

" ------------------------------------------------------------
" Mappings
" ------------------------------------------------------------

" Change leader to ','
let mapleader=","

" New line without Insert mode Enter/Shift+Enter
nmap <leader>O O<Esc>j
nmap <leader>o o<Esc>k

" Edit vimrc
nnoremap <leader>rc :vsp ~/.vimrc<CR><C-L>

" Edit colorscheme
nnoremap <leader>cs :vsp ~/.vim/colors/lucy.vim<CR><C-L>

" Ignore arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
