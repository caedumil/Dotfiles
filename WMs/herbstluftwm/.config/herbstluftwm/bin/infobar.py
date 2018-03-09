#!/usr/bin/env python3

import sys
import dbus
import time
import getopt
import notify2
import subprocess as proc


def volume():
    try:
        proc.run(['ponymix', 'is-mute'], check=True)
    except proc.CalledProcessError:
        icon='\uE203'   # unmuted
    else:
        icon='\uE202'   # muted
    stdout = proc.run(['ponymix', 'get-volume'], stdout=proc.PIPE)
    vol = stdout.stdout.decode()
    return '{}: {}% '.format(icon, vol.strip())


def datetime():
    dateIcon = '\uE265'
    date = time.strftime('%A, %d %B %Y')
    clockIcon = '\uE017'
    clock = time.strftime('%H:%M')
    return '{}: {} {}: {}'.format(dateIcon, date, clockIcon, clock)


def isConnected(technology):
    path = '/net/connman/technology/{}'.format(technology)
    bus = dbus.SystemBus()
    obj = bus.get_object('net.connman', path)
    iface = dbus.Interface(obj, 'net.connman.Technology')
    return iface.GetProperties().get('Connected')


def connection():
    lanIcon = '\uE19C'
    wifiIcon = '\uE222'
    ethIcon = '\uE148'
    conn = []
    if isConnected('wifi'):
        conn.append(wifiIcon)
    if isConnected('ethernet'):
        conn.append(ethIcon)
    fmt = '/'.join(conn) if conn else '\uE217'
    return '{}: {}'.format(lanIcon, fmt)


if __name__ == '__main__':
    notify2.init('wminfobar')
    msg = '[{}] [{}] [{}]'.format(volume(), datetime(), connection())
    bubble = notify2.Notification('', msg)
    bubble.show()
