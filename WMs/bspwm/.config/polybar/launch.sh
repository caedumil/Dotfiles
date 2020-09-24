#!/usr/bin/env bash



if xrandr --query | grep 'HDMI1 connected' >/dev/null 2>&1 ; then
	polybar --reload secondary &
fi
polybar --reload primary &

wait
