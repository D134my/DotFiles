#!/bin/sh

F=`awk '/file/ {print}' ~/.config/nitrogen/bg-saved.cfg | cut -c 6-100000`

wal -i $F
wal_i3rust -c ~/.config/i3status-rust/config.toml

echo $F
