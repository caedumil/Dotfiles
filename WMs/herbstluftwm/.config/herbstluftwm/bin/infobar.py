#!/usr/bin/env python3

import dbus
import time
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
    try:
        obj = bus.get_object('net.connman', path)
    except:
        return False
    else:
        iface = dbus.Interface(obj, 'net.connman.Technology')
        return iface.GetProperties().get('Connected')


def connection():
    lanIcon = '\uE19C'
    offIcon = '\uE217'
    techIcons = {
        'wifi': '\uE222',
        'ethernet': '\uE148',
        'bluetooth': '\uE00B'
    }
    conn = []
    for tech, icon in techIcons.items():
        if isConnected(tech):
            conn.append(icon)
    fmt = '/'.join(conn) if conn else offIcon
    return '{}: {}'.format(lanIcon, fmt)


if __name__ == '__main__':
    notify2.init('wminfobar')
    msg = '[{}] [{}] [{}]'.format(volume(), datetime(), connection())
    bubble = notify2.Notification('', msg)
    bubble.show()
