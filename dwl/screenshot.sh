#!/bin/sh

mode="${1:-area}"
outdir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
outfile="$outdir/screenshot-$(date +%Y%m%d-%H%M%S).png"

if ! command -v grim >/dev/null 2>&1; then
	exit 1
fi

mkdir -p "$outdir"

case "$mode" in
	full)
		grim "$outfile"
		;;
	area)
		if ! command -v slurp >/dev/null 2>&1; then
			exit 1
		fi
		geom=$(slurp)
		[ -n "$geom" ] || exit 0
		grim -g "$geom" "$outfile"
		;;
	*)
		exit 1
		;;
esac

if command -v wl-copy >/dev/null 2>&1; then
	wl-copy < "$outfile"
fi

if command -v notify-send >/dev/null 2>&1; then
	notify-send "Screenshot saved" "$outfile"
fi
