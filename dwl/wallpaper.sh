#!/bin/sh

if ! command -v wbg >/dev/null 2>&1; then
	exit 0
fi

WALLPAPER="${WALLPAPER:-$HOME/Pictures/wallpaper.jpg}"
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"

if [ -d "$WALLPAPER_DIR" ]; then
	for first in "$WALLPAPER_DIR"/*; do
		[ -f "$first" ] || continue
		WALLPAPER="$first"
		break
	done
fi

[ -f "$WALLPAPER" ] || exit 0

if [ -x "$HOME/.config/dwl/matugen-theme.sh" ]; then
	"$HOME/.config/dwl/matugen-theme.sh" "$WALLPAPER" >/dev/null 2>&1 &
fi

exec wbg "$WALLPAPER"
