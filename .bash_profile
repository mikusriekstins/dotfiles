# Source bash prompt from .bash_prompt
[ -r ~/.bash_prompt ] && source ~/.bash_prompt

# Make vim the default editor
export EDITOR="/usr/local/Cellar/vim/7.4.488/bin/vim"

# Alias mvim for MacVim
alias mvim="/Applications/MacVim.app/contents/MacOS/MacVim"

# More useful LS
alias la="ls -a" 
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
