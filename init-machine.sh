user='mikus'
dotfilesUrl='https://github.com/mikusriekstins/dotfiles'

echo "Begin setting up new machine"
cd /home/${user}

# Install tools
echo "Installing development tools"
yes | sudo dnf install git tmux neovim chromium

# Clone dotfiles
if ! test -f /home/${user}/dotfiles; then
  echo "Cloning dotfiles from Github"
  git clone ${dotfilesUrl}
else
  echo "Dotfiles already present"
fi

# Initialize dot files
echo "Symlink dotfile configurations"
cd dotfiles
files="bashrc bash_prompt bash_profile tmux.conf"
for file in $files; do
  if ! test -f /home/${user}/.$file; then
    echo "Creating symlink to $file in home directory"
    ln -s /home/${user}/dotfiles/.$file ~/.$file
  else
    echo "File already exists ${file}"
  fi
done
echo "Creating symlink to NeoVim configuration in .config directory"
ln -s /home/${user}/dotfiles/nvim /home/${user}/.config/nvim
cd /home/${user}

# Install rust
echo "Installing Rust"
yes | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Volta and Nodejs
echo "Installing Volta"
curl https://get.volta.sh | bash
echo "Installing Nodejs"
volta install node

# Done
echo "Setup complete"
node --version
cargo --version
nvim --version

