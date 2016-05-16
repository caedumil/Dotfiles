#!/bin/sh

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="/etc/X11/xinit/.Xresources"
sysmodmap="/etc/X11/xinit/.Xmodmap"

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# tweak touchpad
xinput set-prop --type=int --format=8 \
    "SynPS/2 Synaptics TouchPad" "Synaptics Edge Scrolling" 1 1 0
xinput set-prop --type=int --format=8 \
    "SynPS/2 Synaptics TouchPad" "Synaptics Tap Action" 2 3 0 0 1 3 2

# set mouse pointer
xsetroot -cursor_name left_ptr

# set keyboard layout
setxkbmap -model acer_laptop -layout br

# adjust X screen saver
xset s off
xset dpms 900 1800 3600

# add fonts path to X
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/artwiz-fonts
xset fp rehash

# X11 settings daemon
xsettingsd &

# Load WM
sxhkd &
exec bspwm
