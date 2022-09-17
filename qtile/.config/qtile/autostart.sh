#!/bin/sh

# No scrolling flicker
picom -b --unredir-if-possible --backend xr_glx_hybrid --vsync --use-damage --glx-no-stencil

# Maps Caps-Lock to Backspace
setxkbmap -option caps:backspace

# Starts Synology Drive
synology-drive autostart &

# Starts Albert
albert &
