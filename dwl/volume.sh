#!/bin/sh

if ! command -v wpctl >/dev/null 2>&1; then
	exit 1
fi

sink="@DEFAULT_AUDIO_SINK@"
source="@DEFAULT_AUDIO_SOURCE@"

case "$1" in
	up)
		wpctl set-volume -l 1.5 "$sink" 5%+
		;;
	down)
		wpctl set-volume "$sink" 5%-
		;;
	mute)
		wpctl set-mute "$sink" toggle
		;;
	micmute)
		wpctl set-mute "$source" toggle
		;;
	*)
		exit 1
		;;
esac

if ! command -v notify-send >/dev/null 2>&1; then
	exit 0
fi

if [ "$1" = "micmute" ]; then
	mic_state=$(wpctl get-volume "$source")
	case "$mic_state" in
		*"[MUTED]"*) notify-send "Mic muted" ;;
		*) notify-send "Mic unmuted" ;;
	esac
	exit 0
fi

vol_state=$(wpctl get-volume "$sink")
vol_pct=$(printf '%s\n' "$vol_state" | awk '{printf("%d", $2 * 100)}')
case "$vol_state" in
	*"[MUTED]"*) notify-send "Volume muted" ;;
	*) notify-send "Volume" "${vol_pct}%" ;;
esac
