#!/usr/bin/env zsh

# XDG base directory specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Set language and locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Disable Zsh shell sessions
export SHELL_SESSION_DISABLE=1

# zsh dotfiles location
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
