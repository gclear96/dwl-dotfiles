#!/bin/sh

if ! command -v playerctl >/dev/null 2>&1; then
	exit 1
fi

case "$1" in
	play-pause)
		playerctl play-pause
		;;
	next)
		playerctl next
		;;
	previous)
		playerctl previous
		;;
	*)
		exit 1
		;;
esac
