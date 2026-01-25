#!/bin/sh

# Start somebar status updates. somebar itself must be launched by dwl -s.
# Optional env: SOMEBAR_FIFO to override the FIFO path.

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

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

"$SCRIPT_DIR/status.sh" | while IFS= read -r line; do
	# Use -c as recommended by somebar docs.
	somebar -c status "$line" >/dev/null 2>&1 || true

done
