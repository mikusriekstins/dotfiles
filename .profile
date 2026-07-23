# Environment variables — sourced by login shells and PAM
# (not interactive — no aliases/functions/prompt here)

# Terminal — set 256color TERM for WSL/Windows Terminal when not inside tmux.
# Tmux overrides this with tmux-256color + Tc (truecolor) in ~/.tmux.conf.
if [ -z "$TMUX" ]; then
    export TERM=xterm-256color
fi

# UTF-8
export LANG=C.UTF-8
export LC_ALL=C.UTF-8

# Homebrew (Atomic Fedora)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Rust / Cargo
. "$HOME/.cargo/env"

# Volta (Node.js)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# User-local bin
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Doom Emacs builds (if they exist)
export DOOMEMACS_INSTALL="$HOME/.config/emacs/bin"
export PATH="$DOOMEMACS_INSTALL:$PATH"

# Pico SDK
export PICO_SDK_PATH=~/git/pico-sdk
export PICO_EXAMPLES_PATH=~/git/pico-examples
export PICO_EXTRAS_PATH=~/git/pico-extras
export PICO_PLAYGROUND_PATH=~/git/pico-playground

# ESP32 toolchain
export LIBCLANG_PATH="/home/mikus/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.4-20231113/esp-clang/lib"
export PATH="/home/mikus/.rustup/toolchains/esp/xtensa-esp32-elf/esp-13.2.0_20230928/xtensa-esp32-elf/bin:$PATH"

# LM Studio CLI
export PATH="$PATH:/var/home/orion/.lmstudio/bin"

# ghcup (Haskell)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# App shortcuts
alias dev-enquiry="dev Enquiry '$HOME/enquiry-frontend/src/Enquiry.Bff/ClientApp' 'nvim .' '$HOME/enquiry-frontend/src/Enquiry.Bff' 'dotnet run'"
alias dev-sv="dev Viewer '$HOME/standards-viewer-frontend/src/StandardsViewerFrontend.Client' 'nvim .' '$HOME/standards-viewer-frontend/src/StandardsViewerFrontend.Server' 'dotnet run'"
alias dev-at="dev Authoring '$HOME/authoring-frontend-v2/src/Authoring.Bff/ClientApp' 'nvim .' '$HOME/authoring-frontend-v2/src/Authoring.Bff' 'dotnet run'"
alias dev-cl="dev CL '$HOME/component-library' 'nvim .' '$HOME/component-library' 'npm run storybook'"
