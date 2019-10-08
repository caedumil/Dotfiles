#!/usr/bin/env python3

import os
import threading
import subprocess as proc
import notify2


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
MONITOR = {
    'M': ['<', '>'],
    'm': ['|', '|']
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
            output.extend(mon)
        else:
            output.insert(-1, STATUS[symbol])
    return ' '.join(output)


def main():
    notify2.init('wmtags')
    bubble = notify2.Notification('', '')

    wLoop = threading.Thread(target=idleLoop)
    wLoop.start()

    read = True
    last = None
    status = None
    with open(PIPE, 'r') as rfifo:
        for line in rfifo:
            ln = line.strip()
            status = tags(ln)
            if status != last:
                bubble.update('', status)
                bubble.show()
            last = status

    wLoop.join()


if __name__ == '__main__':
    if not os.path.exists(os.path.dirname(PIPE)):
        os.mkdir(os.path.dirname(PIPE))
    if os.path.exists(PIPE):
        os.remove(PIPE)
    os.mkfifo(PIPE)

    main()
