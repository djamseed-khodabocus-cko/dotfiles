#!/usr/bin/env zsh

# Skip loading for non-interactive shells
case $- in
    *i*) ;;
    *) return ;;
esac

# Source additional dotfiles if they exist
 for file in $ZDOTDIR/.{aliases,dockerfuncs,exports,functions}; do
     [[ -r "$file" && -f "$file" ]] && source "$file"
 done
 unset file

# History settings
HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS  # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_VERIFY       # Do not execute immediately upon history expansion.
setopt SHARE_HISTORY     # Share history between all sessions.

# Enable useful shell options:
#  - autocd - change directory without no need to type 'cd' when changing directory
#  - automenu - enable autocompletion menu
#  - completeinword - complete words at the cursor position
#  - extendedglob - treat '#', '~' and '^' chars as part of patterns for filename generation
#  - menucomplete - cycle through completion with TAB
#  - nullglob - Delete pattern in argument list if no match found
#  - noclobber - prevent file overwrite on stdout redirection
#  - correctall - suggest corrections for mistyped commands
#  - rmstarsilent - prevent accidental 'rm *' disasters
#  - nobeeb - remove the annoying beep sound
#  - nocaseglob - case-insensitive globbing
#  - nocasematch - case-insensitive matching for completion

setopt \
    autocd \
    automenu \
    completeinword \
    extendedglob \
    menucomplete \
    nullglob \
    noclobber \
    correctall \
    rmstarsilent \
    nobeep \
    nocaseglob \
    nocasematch

# Set default permissions for files and directories
# files: 644, directories: 755
umask 002

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# Completion
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload -U compinit; compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
_comp_options+=(globdots) # With hidden files

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

# Enable selection in completion menu
zstyle ':completion:*' menu select

# Initialize Starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Initialize zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Source autosuggestion plugin
if command -v brew &>/dev/null && [ -r "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Source syntax highlighting plugin
if command -v brew &>/dev/null && [ -r "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Add fzf keybindings
if command -v brew &>/dev/null && [ -r "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi

# Initialize pyenv
command -v pyenv &>/dev/null && eval "$(pyenv init - zsh)"

# Source .privaterc
[ -f ~/.privaterc ] &&  source ~/.privaterc
