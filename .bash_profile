# Source bash prompt from .bash_prompt
[ -r ~/.bash_prompt ] && source ~/.bash_prompt

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "/home/mikus/.ghcup/env" ] && source "/home/mikus/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set UTF8
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

# Pico SDK
export PICO_SDK_PATH=~/git/pico-sdk
export PICO_EXAMPLES_PATH=~/git/pico-examples
export PICO_EXTRAS_PATH=~/git/pico-extras
export PICO_PLAYGROUND_PATH=~/git/pico-playground

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
export PATH="$HOME/.cargo/env:$PATH"

export LIBCLANG_PATH="/home/mikus/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.4-20231113/esp-clang/lib"
export PATH="/home/mikus/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Toolbox alias commands
alias cargo-run="toolbox run cargo build && cargo run"
alias cargo-build="toolbox run cargo build"

# Brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Zoxide z jumping
eval "$(zoxide init bash)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/var/home/orion/.lmstudio/bin"

# Uzspelejam tmux sessions
alias ai-dev="bash ~/git/start-tmux.sh"

# Update claude
alias update-claude="sudo npm install -g @anthropic-ai/claude-code"

# Run D
alias dev-elder="z elderfall && tmux new -s elderfall"

# Tmux project helper
source ~/dotfiles/tmux-project.sh

# App shortcuts
alias dev-enquiry="dev Enquiry '$HOME/enquiry-frontend/src/Enquiry.Bff/ClientApp' 'nvim .' '$HOME/enquiry-frontend/src/Enquiry.Bff' 'dotnet run'"
alias dev-sv="dev Viewer '$HOME/standards-viewer-frontend/src/StandardsViewerFrontend.Client' 'nvim .' '$HOME/standards-viewer-frontend/src/StandardsViewerFrontend.Server' 'dotnet run'"
alias dev-at="dev Authoring '$HOME/authoring-frontend-v2/src/Authoring.Bff/ClientApp' 'nvim .' '$HOME/authoring-frontend-v2/src/Authoring.Bff' 'dotnet run'"
alias dev-cl="dev CL '$HOME/component-library' 'nvim .' '$HOME/component-library' 'npm run storybook'"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
