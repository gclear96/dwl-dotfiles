#!/bin/sh

# Launch dwlb with IPC and feed status over the IPC socket.
# Set DWLB_OUTPUT to your output name (e.g. eDP-1) or "all".

OUTPUT="${DWLB_OUTPUT:-eDP-1}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# Gruvbox Material Dark Soft palette
BG0="#32302f"
BG1="#3c3836"
BG2="#504945"
BG4="#7c6f64"
FG0="#d4be98"
RED="#ea6962"
GREEN="#a9b665"
YELLOW="#d8a657"
BLUE="#7daea3"

dwlb -ipc -hide-vacant-tags -center-title \
	-active-fg-color "$FG0" -active-bg-color "$BG2" \
	-occupied-fg-color "$FG0" -occupied-bg-color "$BG1" \
	-inactive-fg-color "$BG4" -inactive-bg-color "$BG0" \
	-urgent-fg-color "$BG0" -urgent-bg-color "$RED" \
	-middle-bg-color "$BG1" -middle-bg-color-selected "$BG2" \
	&
bar_pid=$!

# Give the IPC socket a moment to appear before sending status.
if [ -n "${XDG_RUNTIME_DIR:-}" ]; then
	socket_dir="$XDG_RUNTIME_DIR/dwlb"
	i=0
	while [ $i -lt 20 ]; do
		if ls "$socket_dir"/dwlb-* >/dev/null 2>&1; then
			break
		fi
		if ! kill -0 "$bar_pid" 2>/dev/null; then
			break
		fi
		i=$((i + 1))
		sleep 0.05
	done
fi

"$SCRIPT_DIR/status.sh" | dwlb -status-stdin "$OUTPUT" &
status_pid=$!

trap 'kill "$status_pid" "$bar_pid" 2>/dev/null' INT TERM EXIT
wait "$bar_pid"
