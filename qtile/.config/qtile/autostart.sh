#!/bin/sh

# No scrolling flicker
picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil

# Map Caps-Lock to Backspace
setxkbmap -option caps:backspace

# Map AltGr to compose key
xmodmap -e "keycode 108 = Multi_key"

# Starts Synology Drive
synology-drive autostart &

# Starts Albert
albert &