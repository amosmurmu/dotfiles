#!/bin/sh
set -e

DOTFILES_REPO="https://github.com/amosmurmu/dotfiles.git"
DOTFILES="$HOME/dotfiles"

echo "=== 🚀 Starting dotfiles setup ==="

# --- Clone dotfiles repo ---
if [ ! -d "$DOTFILES" ]; then
  echo "Cloning dotfiles repo..."
  git clone "$DOTFILES_REPO" "$DOTFILES"
else
  echo "Dotfiles already exist, skipping clone."
fi

# --- Basic config symlinks ---
ln -sf "$DOTFILES/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"

echo "✅ Basic shell config linked."

# Symlink .vimrc from dotfiles
if [ -f "$DOTFILES/.vimrc" ]; then
  ln -sf "$DOTFILES/.vimrc" "$HOME/.vimrc"
  echo "✅ .vimrc symlinked."
fi

# Install xclip for system clipboard support
if ! command -v xclip >/dev/null 2>&1; then
  echo "Installing xclip and exa for system clipboard support and icons support"
  sudo apt install -y xclip vim-gtk3 eza
fi

# --- Ensure config directories exist ---
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.tmux/plugins"

# --- Neovim setup ---
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"

# Lazy.nvim (plugin manager)
if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
  echo "Installing Lazy.nvim..."
  git clone https://github.com/folke/lazy.nvim.git \
    "$HOME/.local/share/nvim/lazy/lazy.nvim"
else
  echo "Lazy.nvim already installed."
fi

echo "✅ Neovim config linked and Lazy.nvim ensured."

# --- Tmux setup ---
ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "TPM already installed."
fi

echo "✅ Tmux setup complete."

# --- Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed."
fi

# --- Zsh Plugins & Powerlevel10k ---
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Powerlevel10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "Powerlevel10k already installed."
fi

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# fzf
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --
fi

echo "✅ Oh My Zsh plugins installed."

# --- Install Neovim depending on OS ---
install_debian() {
  echo "Installing Neovim + build tools on Debian..."
  sudo apt update
  sudo apt install -y neovim git curl build-essential
}

install_arch() {
  echo "Installing Neovim on Arch..."
  sudo pacman -Syu neovim base-devel --noconfirm
}

case "$(uname -s)" in
Linux)
  if [ -f /etc/debian_version ]; then
    install_debian
  elif [ -f /etc/arch-release ]; then
    install_arch
  else
    echo "⚠️  Unsupported Linux distribution."
  fi
  ;;
Darwin)
  echo "⚠️  macOS not supported yet. Install Neovim manually."
  ;;
*)
  echo "⚠️  Unsupported OS: $(uname -s)"
  ;;
esac

# --- Reminder for Nerd Fonts ---
echo "⚠️  If using Powerlevel10k, install a Nerd Font on your terminal (e.g. MesloLGS NF)"
echo "   https://github.com/romkatv/powerlevel10k#fonts"

echo "🎉 All setup complete! Open a new terminal and run 'source ~/.zshrc' or 'nvim' to verify."
