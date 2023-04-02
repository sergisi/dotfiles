#!/usr/bin/env bash

WORKINGDIR="$HOME/.config/rofi/scripts/"
MAP="$WORKINGDIR/cmd.csv"

cat "$MAP" \
    | cut -d ',' -f 1 \
    | rofi -dmenu -p "Scripts " \
    | head -n 1 \
    | xargs -i --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
    | head -n 1 \
    | xargs -i --no-run-if-empty /bin/bash -c "{}"

exit 0
