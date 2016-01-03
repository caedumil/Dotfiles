# ~/.profile

#
# Environment variables
#

# SSH
export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Pager
export PAGER="less"
export LESSHISTFILE="-"

# Colored less
# about color code 38:
# Reserved for extended set foreground color.
# Typical supported next arguments are:
# - 5;x (where x is color index (0..255)) or
# - 2;r;g;b (where r,g,b are red, green and blue color channels (out of 255))
export LESS_TERMCAP_mb=$'\E[01;31m'         # begin blinking
export LESS_TERMCAP_md=$'\E[00;38;5;5m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'             # end mode
export LESS_TERMCAP_se=$'\E[0m'             # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'      # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'             # end underline
export LESS_TERMCAP_us=$'\E[00;38;5;177m'   # begin underline

# Zsh dot dir
export ZDOTDIR="$HOME/.zsh"

# Applications
export EDITOR="vim"
