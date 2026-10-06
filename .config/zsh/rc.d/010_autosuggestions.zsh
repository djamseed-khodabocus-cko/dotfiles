# Enable autosuggestions

# Bind widgets once at load instead of on every precmd (performance)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

(($+commands[brew])) \
    && [ -r $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
    && source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
