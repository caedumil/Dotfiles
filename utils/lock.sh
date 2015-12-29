#!/usr/bin/env bash

sshot="$(mktemp --suffix=.png)"
[[ -n ${1} ]] && icon="${1}"

# Take screenshot
maim "${sshot}"

# Pixelate image
convert "${sshot}" -scale 10% -scale 1000% "${sshot}"

# Add lock icon to screenshot
if [[ -e ${icon} ]]; then
    convert "${sshot}" "${icon}" -gravity center -composite -matte "${sshot}"
fi

# Lock screen
i3lock --no-unlock-indicator --image "${sshot}"

# Cleanup
rm "${sshot}"
