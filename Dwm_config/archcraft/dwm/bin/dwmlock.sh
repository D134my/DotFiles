#!/usr/bin/env bash

## Copyright (C) 2020-2021 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## Get colors -----------------
FG="#c8ccd4"
BG="#1e222a"

BLACK="#1e222a"
RED="#e06c75"
GREEN="#98c379"
YELLOW="#e5c07b"
BLUE="#61afef"
MAGENTA="#c678dd"
CYAN="#56b6c2"
WHITE="#abb2bf"

TOTD=`fortune -n 90 -s | head -n 1`

## Exec	-----------------
i3lock \
--color="${BLACK}"			
#--blur 5					\
