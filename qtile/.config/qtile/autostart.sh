#!/bin/sh

# ~/.config/qtile/autostart.sh

# No scrolling flicker
# picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil
picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil

# Map Caps-Lock to Backspace + dvoraks
setxkbmap -option caps:backspace dvorak

# Map AltGr to compose key
xmodmap -e "keycode 108 = Multi_key"

# Starts Albert
albert &

# Starts Synology Drive
synology-drive autostart &

# Starts CopyQ
copyq &

# Set resolution
# xrandr --output eDP-1 --mode 1920x1200

# Activate polybar

# Kill existing polybar instances
killall -q polybar
# Wait for processes to shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Launch polybar
# polybar -r gruvw &
