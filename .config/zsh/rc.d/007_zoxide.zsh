# Initialize zoxide

export _ZO_DOCTOR=0
(($+commands[zoxide])) && eval "$(zoxide init zsh --cmd cd)"
