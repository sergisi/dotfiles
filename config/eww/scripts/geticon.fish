#!/usr/bin/env fish

echo "/usr/share/icons/hicolor/scalable/apps/$(hyprctl activewindow -j | jq ".class" | string replace '"' '' --all).svg"

socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 awk -F '>>|,' '/^activewindow>>/{print "/usr/share/icons/hicolor/scalable/apps/"$2".svg"}'
