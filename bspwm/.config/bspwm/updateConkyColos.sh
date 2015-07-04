#!/usr/bin/env  bash

OLD="$(grep -E -m 1 -o "#[A-Fa-f0-9]{6}" ${1})"
NEW="#$(getXresColor color3)"

sed -i "s;${OLD};${NEW};g" ${1}
