#!/usr/bin/env sh

case $1 in
    "screen")
        sleep 1
        grimblast copysave screen
        notify-send "❤ Took screenshot" -t 1000
        ;;
    "area")
        grim -g "$(slurp)"
        sleep 1
        notify-send "❤ Took screenshot" -t 1000
        ;;
    "window")
        sleep 1
        grimblast copysave area
        notify-send "❤ Took screenshot" -t 1000
        ;;
    "output")
        sleep 1
        grimblast copysave output
        notify-send "❤‍ Took screenshot" -t 1000
        ;;
esac
