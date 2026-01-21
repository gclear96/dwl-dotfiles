#!/bin/sh

# Launch dwlb with IPC and status stdin.
# Set DWLB_OUTPUT to your output name (e.g. eDP-1).

OUTPUT="${DWLB_OUTPUT:-eDP-1}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

"$SCRIPT_DIR/status.sh" | dwlb -ipc -hide-vacant-tags -center-title -status-stdin "$OUTPUT"
