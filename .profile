# Environment variables — sourced by login shells and PAM
# (not interactive — no aliases/functions/prompt here)

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
