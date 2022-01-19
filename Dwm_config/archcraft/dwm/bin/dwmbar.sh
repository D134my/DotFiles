#!/usr/bin/bash

interval=0

## Cpu Info
cpu_info() {
	cpu_load=$(grep -o "^[^ ]*" /proc/loadavg)

	printf "[ CPU "
	printf "$cpu_load ]"
}

## Memory
memory() {
	printf "[  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g) ]"
}

## Wi-fi
wlan() {
	case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
		up) printf "[   Connected ]" ;;
		down) printf "[^c#3b414d^^b#E06C75^ 睊 ^d^%s" " ^c#E06C75^Disconnected ]" ;;
	esac
}

##printf "^c#1e222a^^b#7aa2f7^ $(date '+%a, %I:%M %p') "
## Time
clock() {
	printf "$echo $(jdate '+%Y-%m-%d %E') | $(date '+%I:%M %p')"
}

## System Update
updates() {
	updates=$(checkupdates | wc -l)

	if [ -z "$updates" ]; then
		printf "^c#98C379^  Updated"
	else
		printf "  $updates"" updates"
	fi
}

## Battery Info
battery() {
	BAT=$(upower -i `upower -e | grep 'BAT'` | grep 'percentage' | cut -d':' -f2 | tr -d '%,[:blank:]')
	AC=$(upower -i `upower -e | grep 'BAT'` | grep 'state' | cut -d':' -f2 | tr -d '[:blank:]')

	if [[ "$AC" == "charging" ]]; then
		printf "[  $BAT%% ]"
	elif [[ "$AC" == "fully-charged" ]]; then
		printf "[  Full ]"
	else
		if [[ ("$BAT" -ge "0") && ("$BAT" -le "20") ]]; then
			printf "[   $BAT%% ]"
		elif [[ ("$BAT" -ge "20") && ("$BAT" -le "40") ]]; then
			printf "[   $BAT%% ]"
		elif [[ ("$BAT" -ge "40") && ("$BAT" -le "60") ]]; then
			printf "[   $BAT%% ]"
		elif [[ ("$BAT" -ge "60") && ("$BAT" -le "80") ]]; then
			printf "[   $BAT%% ]"
		elif [[ ("$BAT" -ge "80") && ("$BAT" -le "100") ]]; then
			printf "[   $BAT%% ]"
		fi
	fi
}

## Brightness
brightness() {
	LIGHT=$(printf "%.0f\n" `light -G`)

	if [[ ("$LIGHT" -ge "0") && ("$LIGHT" -le "25") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	elif [[ ("$LIGHT" -ge "25") && ("$LIGHT" -le "50") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	elif [[ ("$LIGHT" -ge "50") && ("$LIGHT" -le "75") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	elif [[ ("$LIGHT" -ge "75") && ("$LIGHT" -le "100") ]]; then
		printf "^c#56B6C2^  $LIGHT%%"
	fi
}

## Main
while true; do
  [ "$interval" == 0 ] || [ $(("$interval" % 3600)) == 0 ] && updates=$(updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "  $(battery) $(cpu_info) $(memory) $(wlan) $(clock)"
done
