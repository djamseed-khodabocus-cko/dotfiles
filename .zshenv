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

# Set `Neovim` as the default text editor
export EDITOR='nvim'
export VISUAL='nvim'

# Better user experience for `less`
export LESS='-F -Q -M -R -X -i -g -s -x4 -z-2'

# Use `Bat` as the default pager for man pages
export MANPAGER="col -bx | bat -l man -p"

# Set the hostname for this computer
if [ -z "$HOSTNAME" ]; then
    HOSTNAME=$(hostname -s)
    export HOSTNAME
fi

# Specify the architecture for build tools and compilers
ARCHFLAGS=$(uname -m)
export ARCHFLAGS

# Ensure homebrew-installed binaries for curl take precedence
if command -v brew &>/dev/null; then
    LIBCURL_CFLAGS="-L$(brew --prefix)/opt/curl/lib"
    LIBCURL_LIBS="-I$(brew --prefix)/opt/curl/include"
    export LIBCURL_CFLAGS LIBCURL_LIBS
fi

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
GPG_TTY=$(tty)
export GPG_TTY

# LS_COLORS sections:
#   Standard -- no... (refer to: https://is.gd/6MzI27)
#   Archive - 7za...
#   Package - deb...
#   Image - jpg...
#   Video - avi...
#   Audio -- flac...
#   Code -- js...
#   Configuration -- *akefile...
#   Template -- erb...
#   Style -- css...
#   Markdown -- md...
#   Document -- pdf...
# Note:
#   mi - completion options color
#   so - completion matching-prefix color
export LS_COLORS="\
di=1;34:fi=0:ln=1;36:pi=1;33:so=1;35:bd=1;33:cd=1;33:ex=1;32:\
*.tar=1;31:*.tgz=1;31:*.arc=1;31:*.arj=1;31:*.taz=1;31:\
*.lha=1;31:*.lz4=1;31:*.lzh=1;31:*.lzma=1;31:*.tlz=1;31:*.txz=1;31:*.tzo=1;31:\
*.t7z=1;31:*.zip=1;31:*.z=1;31:*.Z=1;31:*.dz=1;31:*.gz=1;31:*.lrz=1;31:*.bz2=1;31:\
*.bz=1;31:*.tbz=1;31:*.tbz2=1;31:*.tz=1;31:*.deb=1;31:*.rpm=1;31:*.jar=1;31:\
*.war=1;31:*.ear=1;31:*.sar=1;31:*.rar=1;31:*.alz=1;31:*.ace=1;31:*.zoo=1;31:\
*.cpio=1;31:*.7z=1;31:*.rz=1;31:*.cab=1;31:*.wim=1;31:*.swm=1;31:*.dwm=1;31:*.esd=1;31:\
*.jpg=1;35:*.jpeg=1;35:*.gif=1;35:*.bmp=1;35:*.pbm=1;35:*.pgm=1;35:*.ppm=1;35:*.tga=1;35:\
*.xbm=1;35:*.xpm=1;35:*.tif=1;35:*.tiff=1;35:*.png=1;35:*.svg=1;35:*.svgz=1;35:*.mng=1;35:\
*.pcx=1;35:*.mov=1;35:*.mpg=1;35:*.mpeg=1;35:*.m2v=1;35:*.mkv=1;35:*.webm=1;35:*.ogm=1;35:\
*.mp4=1;35:*.m4v=1;35:*.mp4v=1;35:*.vob=1;35:*.qt=1;35:*.nuv=1;35:*.wmv=1;35:*.asf=1;35:\
*.rm=1;35:*.rmvb=1;35:*.flc=1;35:*.avi=1;35:*.fli=1;35:*.flv=1;35:*.gl=1;35:*.dl=1;35:\
*.xcf=1;35:*.xwd=1;35:*.yuv=1;35:*.cgm=1;35:*.emf=1;35:*.ogv=1;35:*.ogx=1;35:\
*.aac=1;33:*.au=1;33:*.flac=1;33:*.m4a=1;33:*.mid=1;33:*.midi=1;33:*.mka=1;33:*.mp3=1;33:\
*.ogg=1;33:*.ra=1;33:*.wav=1;33:*.oga=1;33:*.opus=1;33:*.spx=1;33:*.xspf=1;33:\
*.sh=1;32:*.bash=1;32:*.zsh=1;32:\
*.log=1;90:*.txt=0;37:\
"

# 'fzf' options
export FZF_DEFAULT_OPTS='
      --height 75% --multi --reverse --margin=0,1
      --bind ctrl-d:page-down,ctrl-u:page-up
      --bind pgdn:preview-page-down,pgup:preview-page-up
      --marker="✚" --pointer="▶" --prompt="❯ "
      --no-separator --scrollbar="█" --border
      --color bg+:#262626,fg+:#dadada,hl:#f09479,hl+:#f09479
      --color border:#303030,info:#cfcfb0,header:#80a0ff,spinner:#36c692
      --color prompt:#87afff,pointer:#ff5189,marker:#f09479'

export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --line-range :500 {}"'
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS='--preview "eza -T | head -n 100"'

# Homebrew
HOMEBREW_PREFIX=/opt/homebrew
export HOMEBREW_PREFIX

# Go related environment variables
export GOROOT=$HOMEBREW_PREFIX/opt/go/libexec
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin

# Pyenv related environment variables
export PYENV_ROOT="$HOME/.pyenv"

# Update MANPATH for GNU tools documentation
export MANPATH="$HOMEBREW_PREFIX/opt/make/libexec/gnuman:$MANPATH"
export MANPATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman:$MANPATH"

# zsh dotfiles location
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
