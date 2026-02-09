[ -n "$PS1" ] && source ~/.bash_profile
. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/var/home/orion/.lmstudio/bin"
# End of LM Studio CLI section

