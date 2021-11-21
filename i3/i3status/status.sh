#!/bin/sh

i3status | while :
do
     read line
	 LG=$(xkblayout-state print %s)
	echo  " $LG | $line    `(jdate '+%Y-%m-%d  %q')` " || exit 1
done

