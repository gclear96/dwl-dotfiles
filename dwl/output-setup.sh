#!/bin/sh

conf="${XDG_CONFIG_HOME:-$HOME/.config}/dwl/outputs.conf"

command -v wlr-randr >/dev/null 2>&1 || exit 0
[ -f "$conf" ] || exit 0

# Wait for outputs to be advertised after compositor startup.
sleep 1

while IFS= read -r line; do
	case "$line" in
		""|\#*)
			continue
			;;
	esac

	set -- $line
	output="$1"
	scale="$2"

	[ -n "$output" ] || continue
	[ -n "$scale" ] || continue

	wlr-randr --output "$output" --scale "$scale" >/dev/null 2>&1 || true
done < "$conf"
