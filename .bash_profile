# Source bash prompt from .bash_prompt
[ -r ~/.bash_prompt ] && source ~/.bash_prompt

# Make vim the default editor
export EDITOR="/usr/local/Cellar/vim/7.4.488/bin/vim"

# Set UTF8
# Setting for the new UTF-8 terminal support
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# More useful LS
alias la="ls -a" 
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

. ~/Git/z/z.sh
