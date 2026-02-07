#!/bin/sh

if ! command -v cliphist >/dev/null 2>&1 || ! command -v wl-copy >/dev/null 2>&1; then
	exit 1
fi

if command -v tofi >/dev/null 2>&1; then
	menu_cmd='tofi --prompt-text "clipboard: " --config "$HOME/.config/tofi/config"'
elif command -v wofi >/dev/null 2>&1; then
	menu_cmd='wofi --dmenu --prompt "clipboard"'
else
	exit 1
fi

selection=$(cliphist list | sh -c "$menu_cmd")
[ -n "$selection" ] || exit 0

printf '%s' "$selection" | cliphist decode | wl-copy
