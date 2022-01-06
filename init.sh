#!/usr/bin/env sh

# Git installed check
git --version >/dev/null 2>&1
GIT_INSTALLED=$?

# Stow installed check
stow --version >/dev/null 2>&1
STOW_INSTALLED=$?

# Stop execution on error
set -e

# Install git
if ! [ $GIT_INSTALLED -eq 0 ]; then
    echo "+ Git is not already installed. Installing..."
    sudo apt install git -y
fi

# Install stow
if ! [ $STOW_INSTALLED -eq 0 ]; then
    echo "+ Stow is not already installed. Installing..."
    sudo apt install stow -y
fi

# Clone dotfiles repo to home directory
echo "+ Cloning gruvw/dotfiles repo to home directory..."
git clone https://github.com/gruvw/dotfiles.git ~/dotfiles

echo "+ Done!"
