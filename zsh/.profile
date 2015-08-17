#
# ~/.profile
#

## SSH Environment
# Setup Envoy
[[ -x $(which envoy) ]] && source <(envoy -d -p)

## XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

## Colored less
export LESS_TERMCAP_mb=$'\E[01;31m'         # begin blinking
export LESS_TERMCAP_md=$'\E[00;38;5;5m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'             # end mode
export LESS_TERMCAP_se=$'\E[0m'             # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'      # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'             # end underline
export LESS_TERMCAP_us=$'\E[00;38;5;177m'   # begin underline
# code 38
# Reserved for extended set foreground color.
# Typical supported next arguments are:
# - 5;x (where x is color index (0..255)) or
# - 2;r;g;b (where r,g,b are red, green and blue color channels (out of 255))

## Java Options
opt1="swing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
opt2="swing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_OPTIONS="-D${opt1} -D${opt2}"

## Misc
export BROWSER="firefox"
export EDITOR="vim"
