#!/bin/sh

if ! command -v brightnessctl >/dev/null 2>&1; then
	exit 1
fi

case "$1" in
	up)
		brightnessctl set +5% >/dev/null
		;;
	down)
		brightnessctl set 5%- >/dev/null
		;;
	*)
		exit 1
		;;
esac

if command -v notify-send >/dev/null 2>&1; then
	level=$(brightnessctl get)
	max=$(brightnessctl max)
	pct=$((100 * level / max))
	notify-send "Brightness" "${pct}%"
fi
