#!/usr/bin/env zsh

# Skip loading for non-interactive shells
case $- in
    *i*) ;;
    *) return ;;
esac

# Source additional dotfiles if they exist
for file in $ZDOTDIR/.{paths,aliases,functions,dockerfuncs,privaterc}; do
    [[ -r "$file" && -f "$file" ]] && source "$file"
done
unset file

# History settings
HISTFILE="$XDG_CACHE_HOME/zsh_history"
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
    nocaseglob \
    nocasematch

# Set default permissions for files and directories
# files: 644, directories: 755
umask 002

# Initialize Starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Initialize zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Add fzf keybindings
if command -v brew &>/dev/null && [ -r "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi
