#!/usr/bin/env bash

## Copyright (C) 2020-2021 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Kill already running process
_ps=( dunst ksuperkey mpd xfce-polkit xfce4-power-manager)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# Fix cursor
xsetroot -cursor_name left_ptr

# Polkit agent
/usr/lib/xfce-polkit/xfce-polkit &

# Enable power management
xfce4-power-manager &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# Restore wallpaper
hsetroot -cover /usr/share/archcraft/dwm/wallpapers/default.png

# Lauch dwmbar
/usr/share/archcraft/dwm/bin/dwmbar.sh &

# Lauch notification daemon
/usr/share/archcraft/dwm/bin/dwmdunst.sh

# Lauch compositor
/usr/share/archcraft/dwm/bin/dwmcomp.sh

# Start mpd
exec mpd &

## Add your autostart programs here --------------
exec xrandr --output eDP-1 --off --output DP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-1 --off --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal

## -----------------------------------------------

# Launch DWM
dwm
