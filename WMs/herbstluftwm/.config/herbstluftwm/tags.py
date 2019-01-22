#!/usr/bin/env python3

import os
import threading
import subprocess as proc
import notify2


PIPE = '/tmp/wm/herbstluftwm.fifo'
SYMBOLS = {
    '#': '[X]',
    '.': '[ ]',
    ':': '[-]',
    '!': '[!]'
}


def idleLoop():
    with open(PIPE, 'w') as wfifo:
        proc.Popen(['herbstclient', '--idle'], stdout=wfifo)


def tags():
    stdout = proc.run(
        ['herbstclient', 'tag_status'],
        stdout=proc.PIPE,
        universal_newlines=True
    )
    status = stdout.stdout.strip()
    info = [SYMBOLS.get(x[0]) for x in status.split()]
    return ' '.join(info)


def main():
    notify2.init('wmtags')
    bubble = notify2.Notification('', '')

    wLoop = threading.Thread(target=idleLoop)
    wLoop.start()

    read = True
    while read:
        rfifo = open(PIPE, 'r')
        for line in rfifo:
            ln = line.strip()
            if ln.startswith('tag_changed'):
                bubble.update('', tags())
                bubble.show()
            elif ln == 'quit' or ln == 'reload':
                read = False
                break
        rfifo.close()

    wLoop.join()


if __name__ == '__main__':
    if not os.path.exists(os.path.dirname(PIPE)):
        os.mkdir(os.path.dirname(PIPE))
    if os.path.exists(PIPE):
        os.remove(PIPE)
    os.mkfifo(PIPE)

    main()
