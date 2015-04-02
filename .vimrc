
" Author: Mikus Riekstins (mikus.riekstins@gmail.com)
" Last update 2015

" ------------------------------------------------------------
" Plugins
" ------------------------------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'SirVer/ultisnips'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'

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
set clipboard+=unnamed          " Use system clipboard *

" ------------------------------------------------------------
" Movement
" ------------------------------------------------------------


set scrolloff=3                 " Cursor offset for scrolling

" ------------------------------------------------------------
" User Interface
" ------------------------------------------------------------

set number                      " Line numbers
set numberwidth=4               " Make space for at least 4
set laststatus=2                " Always show status line
set background=dark             " Dark variation of colorscheme
colorscheme solarized           " Set colorscheme
set splitbelow                  " H-Split to bottom
set splitright                  " V-Split to right
set cursorline                  " Highlighted current line
set guifont=Input:h20           " Font for MacVim
set rnu                         " Relative line numbers
set cc=80                       " Color column 80
set list                        " Show hidden characters
set listchars=eol:¬,trail:•     " Set hidden characters
hi NonText ctermfg=23 guifg=#005f5f

" Save view (for folds) to .vimrc on buffer switching
autocmd BufWinLeave .vimrc mkview
autocmd BufWinEnter .vimrc silent loadview 

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

" Simpler split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let mapleader=","               " Change the leader to ','

" New line without Insert mode Enter/Shift+Enter
nmap <leader>O O<Esc>j
nmap <leader>o o<Esc>k

" Buffer movement with listing
nnoremap <leader>n :bnext<CR>:ls<CR>
nnoremap <leader>p :bprevious<CR>:ls<CR>

nnoremap <leader>rc :vsp ~/.vimrc<CR><C-L>

