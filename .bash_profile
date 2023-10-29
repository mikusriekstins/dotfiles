# Source bash prompt from .bash_prompt
[ -r ~/.bash_prompt ] && source ~/.bash_prompt

# Set UTF8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# More useful LS
alias la="ls -a"
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Gzip size
function gz() {
  echo "orig size    (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
. "$HOME/.cargo/env"
