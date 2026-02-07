#!/bin/sh

battery=
for b in /sys/class/power_supply/BAT*; do
	if [ -d "$b" ]; then
		battery="$b"
		break
	fi
done

[ -n "$battery" ] || exit 0

low_sent=0
critical_sent=0

while :; do
	status=$(cat "$battery/status" 2>/dev/null)
	capacity=$(cat "$battery/capacity" 2>/dev/null)

	if [ "$status" = "Discharging" ]; then
		if [ "$capacity" -le 10 ] && [ "$critical_sent" -eq 0 ]; then
			if command -v notify-send >/dev/null 2>&1; then
				notify-send -u critical "Battery critical" "${capacity}% remaining"
			fi
			critical_sent=1
		elif [ "$capacity" -le 20 ] && [ "$low_sent" -eq 0 ]; then
			if command -v notify-send >/dev/null 2>&1; then
				notify-send -u normal "Battery low" "${capacity}% remaining"
			fi
			low_sent=1
		fi
	else
		low_sent=0
		critical_sent=0
	fi

	sleep 60
done
