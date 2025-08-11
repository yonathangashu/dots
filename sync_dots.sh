#!/bin/bash
set -euo pipefail

DOTFILES_DIR=~/personal/dotfiles
CONFIG_DIR=~/.config

# List of config directories to sync and stow
declare -a CONFIG_ITEMS=(
    "kitty"
    "waybar"
    "nwg-look"
    "nwg-panel"
    "gtk-3.0"
    "ibus"
    "nautilus"
    "user-dirs"
    "user-dirs-locale"
    "nvim" # add nvim since you want to stow it too
    "hypr" # and hypr as well
)

# List of home dotfiles (copy only, no stow)
declare -a HOME_DOTFILES=(
    ".bashrc"
    ".zshrc"
    ".gitconfig"
    ".ssh"
)

echo "Starting sync of dotfiles..."

# Copy config items, then stow them
for item in "${CONFIG_ITEMS[@]}"; do
    src="$CONFIG_DIR/$item"
    dest="$DOTFILES_DIR/$item"

    if [ -e "$src" ]; then
        if [ -e "$dest" ]; then
            echo "$item already exists in dotfiles repo, skipping copy."
        else
            echo "Copying $src to $dest"
            cp -r "$src" "$dest"
        fi
        # Run stow for this config item targeting ~/.config
        echo "Running stow for $item..."
        stow -v -t ~/.config "$item"
    else
        echo "$src does not exist, skipping."
    fi
done

# Copy home dotfiles, no stow needed
for file in "${HOME_DOTFILES[@]}"; do
    src="$HOME/$file"
    dest="$DOTFILES_DIR/${file#.}"

    if [ -e "$src" ]; then
        if [ -e "$dest" ]; then
            echo "$file already exists in dotfiles repo, skipping."
        else
            echo "Copying $src to $dest"
            if [ -d "$src" ]; then
                cp -r "$src" "$dest"
            else
                cp "$src" "$dest"
            fi
        fi
    else
        echo "$src does not exist, skipping."
    fi
done

echo "Sync and stow complete. Remember to add, commit, and push your dotfiles repo."
