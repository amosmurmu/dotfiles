cat > ~/.zshrc << 'EOF'
# ~/.zshrc: executed by zsh for interactive shells.

# Set the default editor
export EDITOR=nvim

# Enable command auto-completion
autoload -Uz compinit
compinit

# Enable syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias definitions.
alias ll='ls -la'
EOF
