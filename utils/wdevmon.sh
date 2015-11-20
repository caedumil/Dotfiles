#!/bin/bash

PID=$(pidof -x devmon)
[[ -n ${PID} ]] && kill ${PID}

devmon --sync --no-gui\
    --exec-on-drive "notify-send -a Media 'Mounted' %l"\
    --exec-on-unmount "notify-send -a Media 'Safe to remove' %l"
