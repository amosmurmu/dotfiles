#!/bin/sh

DOTFILES_REPO="https://github.com/amosmurmu/dotfiles.git"

if [ ! -d "$HOME/dotfiles" ]; then
    git clone "$DOTFILES_REPO" "$HOME/dotfiles"
fi

ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

ln -sf "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"

# Function to install Neovim on Debian
install_debian() {
    echo "Installing Neovim on Debian..."
    sudo apt update && sudo apt install neovim -y
}

# Function to install Neovim on Arch
install_arch() {
    echo "Installing Neovim on Arch..."
    sudo pacman -Syu neovim --noconfirm
}

# Function to install Neovim on WSL (Windows)
install_wsl() {
    echo "Installing Neovim on Windows (WSL)..."
    if ! command -v neovim &> /dev/null; then
        sudo apt update && sudo apt install neovim -y
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "Oh My Zsh is already installed."
    fi
}

# Detect OS and install Neovim accordingly
case "$(uname -s)" in
    Linux)
        if [ -f /etc/debian_version ]; then
            install_debian
        elif [ -f /etc/arch-release ]; then
            install_arch
        else
            echo "Unsupported Linux distribution."
        fi
        ;;
    Darwin)
        echo "MacOS is not supported yet. Please install Neovim manually."
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        ;;
esac

install_oh_my_zsh

echo "Dotfiles setup complete!"
