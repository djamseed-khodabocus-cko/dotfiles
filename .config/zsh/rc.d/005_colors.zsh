# Enable color support for BSD `ls`
export CLICOLOR=1
export LSCOLORS=GxFxCxDxCxegedabagaced

# Use for `eza` output
(($+commands[vivid])) && export LS_COLORS=$(vivid generate rose-pine-moon)
