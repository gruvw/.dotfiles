#!/usr/bin/env bash

# Git install
git --version > /dev/null 2>&1
if ! [ $? -eq 0 ]; then
    echo "Git is not already installed. Installing..."
    sudo apt install git -y
fi

# Clone dotfiles repo to home directory
echo "Cloning dotfiles repo to home directory..."
git clone https://github.com/gruvw/dotfiles.git ~/dotfiles

echo "Done!"
