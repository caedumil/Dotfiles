#!/usr/bin/env bash

set -e

PANEL_FIFO="/tmp/herbs_panel.fifo"
WM_DIR="${HOME}/.config/herbstluftwm/panel"

FG="#FF$(getXresColor.sh foreground)"
BG="#FF$(getXresColor.sh background)"

monitor="${1:-0}"

if [[ $(pgrep -cx panel.sh) -gt 1 ]]; then
    printf "%s\n" "The panel is already running." >&2
    exit 1
fi

trap "trap - TERM; kill 0" INT TERM QUIT EXIT

[[ -e ${PANEL_FIFO} ]] && rm ${PANEL_FIFO}
mkfifo ${PANEL_FIFO}

herbstclient pad ${monitor} 20

conky -c ${WM_DIR}/conkyrc > ${PANEL_FIFO} &
herbstclient --idle > ${PANEL_FIFO} &

${WM_DIR}/panel_format.sh < ${PANEL_FIFO} \
    | lemonbar -g "x20++" -u 3 -F "${FG}" -B "${BG}" \
      -f "-*-siji-medium-*-normal-*-*-*-*-*-*-*-*-*" \
      -f "-*-lime-medium-*-normal-*-*-*-*-*-*-*-*-*"

wait
