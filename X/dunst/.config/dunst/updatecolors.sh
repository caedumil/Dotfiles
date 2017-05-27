#!/usr/bin/env bash

# filename
file=${1}

# frame border
fr_color="118"

# urgency low
urg_low_bg="142"
urg_low_fg="143"

# urgency normal
urg_nor_bg="147"
urg_nor_fg="148"

# urgency critical
urg_cri_bg="152"
urg_cri_fg="153"

# colors
bg="$(getXresColor.sh background)"
fg="$(getXresColor.sh foreground)"
altfg="$(getXresColor.sh brightblack)"

# find & replace
sed -i -r "${fr_color}s/[0-9A-Fa-f]{6}/${fg}/;${urg_nor_fg}s/[0-9A-Fa-f]{6}/${fg}/;${urg_cri_bg}s/[0-9A-Fa-f]{6}/${fg}/" ${file}
sed -i -r "${urg_low_bg}s/[0-9A-Fa-f]{6}/${bg}/;${urg_nor_bg}s/[0-9A-Fa-f]{6}/${bg}/;${urg_cri_fg}s/[0-9A-Fa-f]{6}/${bg}/" ${file}
sed -i -r "${urg_low_fg}s/[0-9A-Fa-f]{6}/${altfg}/" ${file}
