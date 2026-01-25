#!/bin/sh

# Start someblocks for somebar. somebar must be running (dwl -s somebar).
# Optional env: SOMEBAR_FIFO to override the FIFO path.

if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
	echo "XDG_RUNTIME_DIR is not set; cannot find somebar FIFO" >&2
	exit 1
fi

FIFO="${SOMEBAR_FIFO:-$XDG_RUNTIME_DIR/somebar-0}"

# Wait briefly for somebar to create its FIFO.
i=0
while [ $i -lt 50 ]; do
	if [ -p "$FIFO" ]; then
		break
	fi
	i=$((i + 1))
	sleep 0.1
done

exec someblocks -s "$FIFO"
