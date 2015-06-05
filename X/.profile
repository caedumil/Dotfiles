#
# ~/.profile
#

## SSH Environment
# Setup Envoy
source <(envoy -d -p)

## XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

## Java Options
opt1="swing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
opt2="swing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_OPTIONS="-D${opt1} -D${opt2}"

## Misc
export BROWSER="firefox"
export EDITOR="vim"
