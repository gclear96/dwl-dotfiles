#!/bin/sh

lockcmd="$HOME/.config/dwl/lock.sh"

if [ ! -x "$lockcmd" ]; then
	lockcmd="swaylock -f"
fi

exec swayidle -w \
	timeout 300 "$lockcmd" \
	timeout 600 'if command -v wlopm >/dev/null 2>&1; then wlopm --off "*"; fi' \
	resume 'if command -v wlopm >/dev/null 2>&1; then wlopm --on "*"; fi' \
	before-sleep "$lockcmd"
