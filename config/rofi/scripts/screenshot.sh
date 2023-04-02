#!/usr/bin/env sh

case $1 in
    "screen")
        grimblast copysave screen
        notify-send "❤ Took screenshot" -t 1000
        ;;
    "area")
        grim -g "$(slurp)"
        notify-send "❤ Took screenshot" -t 1000
        ;;
    "window")
        grimblast copysave area
        notify-send "❤ Took screenshot" -t 1000
        ;;
    "output")
        grimblast copysave output
        notify-send "❤‍ Took screenshot" -t 1000
        ;;
esac
