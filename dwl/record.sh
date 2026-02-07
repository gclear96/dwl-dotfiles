#!/bin/sh

pidfile="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"
outdir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
outfile="$outdir/recording-$(date +%Y%m%d-%H%M%S).mp4"

if ! command -v wf-recorder >/dev/null 2>&1; then
	exit 1
fi

if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
	kill "$(cat "$pidfile")"
	rm -f "$pidfile"
	if command -v notify-send >/dev/null 2>&1; then
		notify-send "Recording stopped"
	fi
	exit 0
fi

mkdir -p "$outdir"

if command -v notify-send >/dev/null 2>&1; then
	notify-send "Recording started" "$outfile"
fi

wf-recorder -f "$outfile" >/dev/null 2>&1 &
echo "$!" > "$pidfile"
