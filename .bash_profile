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

# Work
tmux-project() {
    local project_dir="$1"
    local server_dir="$2"
    local session="$3"
    local win0="${4:-nvim}"

    # Validate required arguments
    if [[ -z "$project_dir" || -z "$server_dir" || -z "$session" ]]; then
        echo "Usage: tmux-project <project_dir> <server_dir> <session_name> [window_name]" >&2
        return 1
    fi

    # Ensure project_dir and server_dir exist
    if [[ ! -d "$project_dir" ]]; then
        echo "Error: project_dir does not exist: $project_dir" >&2
        return 1
    fi
    if [[ ! -d "$server_dir" ]]; then
        echo "Error: server_dir does not exist: $server_dir" >&2
        return 1
    fi

    if ! tmux has-session -t "$session" 2>/dev/null; then
        tmux new-session -s "$session" -c "$project_dir" -n "$win0" \; \
            send-keys "nvim ." Enter \; \
            new-window -t "$session" -n "server" -c "$server_dir" \; \
            send-keys "dotnet run" Enter \; \
            select-window -t "$session:$win0"
    else
        tmux attach-session -t "$session"
    fi
}

tmux-enquiry() {
    tmux-project \
        "$HOME/enquiry-frontend/src/Enquiry.Bff/ClientApp" \
        "$HOME/enquiry-frontend/src/Enquiry.Bff" \
        "Enquiry"
}

tmux-sv() {
    tmux-project \
        "$HOME/standards-viewer-frontend/src/StandardsViewerFrontend.Client" \
        "$HOME/standards-viewer-frontend/src/StandardsViewerFrontend.Server" \          # adjust: e.g. "$HOME/vs-project/src/Vs.Web"
        "Viewer"
}

enquiry() { tmux-enquiry "$@"; }
sv()      { tmux-sv      "$@"; }

dev() {
    case "${1:-}" in
        enq) shift; tmux-enquiry "$@" ;;
        sv)  shift; tmux-sv      "$@" ;;
        "")  echo "Usage: dev {enq|sv}" >&2; return 1 ;;
        *)   echo "Error: Unknown command '$1'. Available: enq, sv" >&2; return 1 ;;
    esac
}

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
