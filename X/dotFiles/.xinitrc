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

# set mouse pointer
xsetroot -cursor_name left_ptr

# adjust X screen saver
xset s 900
xset dpms 0 1200 1500

# add fonts path to X
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp /usr/share/fonts/local
xset fp rehash

# turn on numlock key
#numlockx on

# start systemd user session target
systemctl --user start bspwm-session.target

# Load WM
exec bspwm
