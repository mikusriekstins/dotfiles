# Interactive bash — aliases, functions, prompt, completions

# Source profile for env vars if not already sourced (covers non-login shells)
if [ -z "$PROFILE_SOURCED" ] && [ -r ~/.profile ]; then
    source ~/.profile
    PROFILE_SOURCED=1
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bling (eza, bat, ugrep aliases)
test -f /usr/share/ublue-os/bling/bling.sh && source /usr/share/ublue-os/bling/bling.sh

# Zoxide
eval "$(zoxide init bash)"

# Prompt
[ -r ~/.bash_prompt ] && source ~/.bash_prompt

# Aliases
alias la="ls -a"
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ai-dev="bash ~/git/start-tmux.sh"
alias update-claude="sudo npm install -g @anthropic-ai/claude-code"
alias cargo-run="toolbox run cargo build && cargo run"
alias cargo-build="toolbox run cargo build"

# Functions
gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size    (bytes): "
    gzip -c "$1" | wc -c
}

llama-up() {
    echo "Starting llama-server..."
    podman start llama-server
    echo "llama-server is running on http://localhost:8080"
}

llama-down() {
    if podman container exists llama-server 2>/dev/null; then
        echo "Stopping llama-server..."
        podman stop llama-server
        echo "llama-server stopped"
    else
        echo "llama-server container does not exist"
    fi
}

# Tmux project helper
source ~/Development/dotfiles/tmux-project.sh
