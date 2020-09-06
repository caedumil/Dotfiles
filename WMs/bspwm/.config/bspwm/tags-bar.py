#!/usr/bin/env python3


import re
import signal
import selectors
import subprocess as proc


MONITORS = {
    '000': '300x20+810+0',
    '001': '300x20+2490+0'
}

SYMBOLS = {
    'F': '\uE1BC',
    'O': '\uE1C2',
    'U': '\uE1C4',
    'f': '\uE1BC',
    'o': '\uE1C2',
    'u': '\uE1C4'
    # 'F': '[ ]',
    # 'O': '[x]',
    # 'U': '[!]',
    # 'f': '[ ]',
    # 'o': '[x]',
    # 'u': '[!]'
}

COLORS = {
    'FG': '#D8DEE9',
    'BG': '#2E3440'
}

REGEX = re.compile(r'[Mm]00[01]')

RUN = True


class Bar():
    def __init__(self, geometry):
        self._active = False
        self._tag = ''
        self._cmd = [
            'lemonbar',
            '-B', COLORS['BG'],
            '-F', COLORS['FG'],
            '-U', COLORS['FG'],
            '-g', geometry,
            '-u', '2',
            '-f', '-windows-dina-medium-r-normal-*-*-*-*-*-*-*-*-*',
            '-f', '-wuncon-siji-medium-r-normal-*-*-*-*-*-*-*-*-*',
        ]
        self._bar = proc.Popen(self._cmd, stdin=proc.PIPE)

    @property
    def active(self):
        return self._active

    @active.setter
    def active(self, value):
        self._active = value

    def draw(self):
        self._bar.stdin.write(self._tag.encode('utf-8'))
        self._bar.stdin.flush()

    def tags(self, ln):
        output = ['%{c}']
        ws = filter((lambda x: x[0] in SYMBOLS.keys()), ln.strip(':').split(':'))
        for status in ws:
            stt = status[0]
            if stt.isupper() and self._active:
                out = '%{{R}} {0} %{{R}}'.format(SYMBOLS[stt])
            elif stt.isupper():
                out = '%{{+o}} {0} %{{-o}}'.format(SYMBOLS[stt])
            else:
                out = ' {0} '.format(SYMBOLS[stt])
            output.append(out)
        output.append('\n')
        self._tag = ' '.join(output)


def sigint(signal, frame):
    global RUN
    RUN = False


def main():
    global MONITORS
    MONITORS['000'] = Bar(MONITORS['000'])
    MONITORS['001'] = Bar(MONITORS['001'])

    proc.run(['bspc', 'config', 'top_padding', '20'])
    select = selectors.DefaultSelector()
    wm = proc.Popen(['bspc', 'subscribe', 'report'], stdout=proc.PIPE)
    select.register(wm.stdout, selectors.EVENT_READ)

    signal.signal(signal.SIGINT, sigint)

    while RUN:
        events = select.select()
        for key, _ in events:
            action = key.fileobj.read1(1024)
            if not action:
                break
            ln = action.decode('utf-8').strip()
            active_mon = '000' if ln.index('M') == 1 else '001'
            MONITORS[active_mon].active = True
            tags = REGEX.split(ln)[1:]
            for mon in zip(MONITORS.values(), tags):
                mon[0].tags(mon[1])
                mon[0].draw()
                mon[0].active = False


if __name__ == '__main__':
    main()
