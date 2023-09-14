#!/bin/sh

# ~/.config/qtile/autostart.sh

# No scrolling flicker
picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil

# Natural scrolling
xmodmap ./Xmodmap &

# Map Caps-Lock to Backspace + dvorak
setxkbmap -option caps:backspace dvorak

# Map AltGr to compose key
xmodmap -e "keycode 108 = Multi_key"

# Starts Albert
albert &

# Starts Synology Drive
synology-drive autostart &

# Starts CopyQ
copyq &
