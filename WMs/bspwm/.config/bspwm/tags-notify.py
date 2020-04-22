#!/usr/bin/env python3

import os
import threading
import subprocess as proc
from collections import namedtuple

from pydbus import SessionBus


PIPE = '/tmp/wm/bspwm.fifo'
SYMBOLS = ['m', 'f', 'o', 'u']
STATUS = {
    'F': '[X]',
    'O': '[X]',
    'U': '[X]',
    'f': '[ ]',
    'o': '[-]',
    'u': '[!]'
}
MON = namedtuple('Monitor', ['starter', 'func'])
MONITOR = {
    'M': MON(
        starter=[':', ':'],
        func=str
        ),
    'm': MON(
        starter=['.', '.'],
        func=str.lower
    )
}


def idleLoop():
    with open(PIPE, 'w') as wfifo:
        proc.Popen(['bspc', 'subscribe', 'report'], stdout=wfifo)


def tags(ln):
    output = []
    workspaces = filter((lambda x: x[0].lower() in SYMBOLS), ln[1:].split(':'))
    for status in workspaces:
        symbol = status[0]
        mon = MONITOR.get(symbol)
        if mon:
            output.extend(mon.starter)
            func = mon.func
        else:
            output.insert(-1, func(STATUS[symbol]))
    return ' '.join(output)


def main():
    bus = SessionBus()
    bubble = bus.get('.Notifications')

    app_name = 'wmtags'
    app_id = 0
    app_icon = ''
    summary = ''
    status = None
    action = []
    hint = {}
    expiration = -1

    wLoop = threading.Thread(target=idleLoop)
    wLoop.start()

    read = True
    last = None
    with open(PIPE, 'r') as rfifo:
        for line in rfifo:
            ln = line.strip()
            status = tags(ln)
            if status != last:
                body = status
                app_id = bubble.Notify(
                    app_name,
                    app_id,
                    app_icon,
                    summary,
                    status,
                    action,
                    hint,
                    expiration
                )
            last = status

    wLoop.join()


if __name__ == '__main__':
    if not os.path.exists(os.path.dirname(PIPE)):
        os.mkdir(os.path.dirname(PIPE))
    if os.path.exists(PIPE):
        os.remove(PIPE)
    os.mkfifo(PIPE)

    main()
