cat >~/.bashrc <<'EOF'
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set a few things for interactive bash users
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"

# enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Alias definitions.
alias ll='ls -la'
EOF
