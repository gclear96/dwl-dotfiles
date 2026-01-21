#!/bin/sh

# Launch dwlb with IPC and status stdin.
# Set DWLB_OUTPUT to your output name (e.g. eDP-1).

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

"$SCRIPT_DIR/status.sh" | dwlb -ipc -hide-vacant-tags -center-title \
	-active-fg-color "$FG0" -active-bg-color "$BG2" \
	-occupied-fg-color "$FG0" -occupied-bg-color "$BG1" \
	-inactive-fg-color "$BG4" -inactive-bg-color "$BG0" \
	-urgent-fg-color "$BG0" -urgent-bg-color "$RED" \
	-middle-bg-color "$BG1" -middle-bg-color-selected "$BG2" \
	-status-stdin "$OUTPUT"
