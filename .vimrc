" Made & Used by: Mikus Riekstins (@mikusriekstins)
" Last change:    2015 Feb 23

" Enable Pathogen
execute pathogen#infect()

" Use Vim instead of Vi settings
set nocompatible

" Make backspace behave normaly
set backspace=indent,eol,start

" Enable file type detection and language-dependent intenting
filetype plugin indent on

" Enable syntax highlighting on
syntax enable

" Line numbers
set number
set numberwidth=5

" Always show status line
set laststatus=2

" Set colorscheme
colorscheme skittles_berry

" Size of tabs
set tabstop=2

" Size of an indent
set shiftwidth=2

" Soft tab size
set softtabstop=2

" Tab insterts indents instead of tabs on new line
set smarttab

" Always use spaces instead of tab
set expandtab

" Disable backup & swap files
set nobackup
set nowritebackup
set noswapfile

" Simpler split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural split opening on right and bottom
set splitbelow
set splitright

" Hide mode status (due to statusline plugin)
set noshowmode

" Highlighted current line
set cursorline

" Cursor offset for scrolling
set scrolloff=3

" Change the leader to ','
let mapleader=","

" Enable for buffers to be left unsaved when
" onpening/switching buffers
set hidden

" Do not wrap lines
" set nowrap

" Enable autoindent
set autoindent

" Line break
set wrap linebreak nolist

" Relative line numbers
set rnu

" Font for MacVim
set guifont=Input:h20

" New line without Insert mode Enter/Shift+Enter
nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k
