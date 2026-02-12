#!/bin/bash

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/old_dotfiles                         # old dotfiles backup directory

# list of dotfiles to symlink in homedir
dotfiles=".bashrc .bash_prompt .bash_profile .tmux.conf"

##########

# Install Homebrew if not already installed
echo "Checking for Homebrew installation..."
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for this session
  if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ -d "$HOME/.linuxbrew" ]]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
  fi

  echo "Homebrew installed successfully!"
else
  echo "Homebrew is already installed."
fi

# Install required packages
echo ""
echo "Installing packages with Homebrew..."

packages=("zoxide" "neovim")
for package in "${packages[@]}"; do
  if brew list "$package" &> /dev/null; then
    echo "$package is already installed."
  else
    echo "Installing $package..."
    brew install "$package"
  fi
done

echo "Package installation complete!"
echo ""

# create old_dotfiles backup directory
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to old_dotfiles directory, then create symlinks
for file in $dotfiles; do
  if [ -f ~/$file ] || [ -L ~/$file ]; then
    echo "Moving existing $file from ~ to $olddir"
    mv ~/$file $olddir/
  fi
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/$file
done

# handle nvim config directory
echo ""
echo "Setting up nvim config directory"
mkdir -p ~/.config

if [ -d ~/.config/nvim ] || [ -L ~/.config/nvim ]; then
  echo "Moving existing nvim config from ~/.config/nvim to $olddir"
  mv ~/.config/nvim $olddir/nvim
fi

echo "Creating symlink to nvim config directory"
ln -s $dir/nvim ~/.config/nvim

# handle opencode config directory
echo ""
echo "Setting up opencode config directory"
mkdir -p ~/.config

if [ -d ~/.config/opencode ] || [ -L ~/.config/opencode ]; then
  echo "Moving existing nvim config from ~/.config/opencode to $olddir"
  mv ~/.config/opencode $olddir/opencode
fi

echo "Creating symlink to opencode config directory"
ln -s $dir/opencode ~/.config/opencode

echo ""
echo "Dotfiles setup complete!"
