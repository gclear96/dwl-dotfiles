#!/bin/sh

if ! command -v wl-paste >/dev/null 2>&1 || ! command -v cliphist >/dev/null 2>&1; then
	exit 0
fi

wl-paste --type text --watch cliphist store &
text_pid=$!
wl-paste --type image --watch cliphist store &
image_pid=$!

wait "$text_pid" "$image_pid"
