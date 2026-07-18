# Source .bash_profile for non-login interactive shells if it hasn't been
# sourced yet (prevents double-sourcing since .bash_profile also sources .bashrc).
# The guard variable is set in .bash_profile itself (not exported), so it only
# protects within the current shell session.
if [ -z "$_BASH_PROFILE_SOURCED" ] && [ -f "$HOME/.bash_profile" ]; then
    . "$HOME/.bash_profile"
    return
fi

. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/var/home/orion/.lmstudio/bin"
# End of LM Studio CLI section

### bling.sh source start
test -f /usr/share/ublue-os/bling/bling.sh && source /usr/share/ublue-os/bling/bling.sh
### bling.sh source end
