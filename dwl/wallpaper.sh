#!/bin/sh

WALLPAPER="${WALLPAPER:-$HOME/Pictures/wallpaper.jpg}"
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
STATE_LINK="${XDG_CACHE_HOME:-$HOME/.cache}/dwl/current-wallpaper"
SET_SCRIPT="$HOME/.config/dwl/set-wallpaper.sh"

if [ -L "$STATE_LINK" ] && [ -f "$STATE_LINK" ]; then
  WALLPAPER="$STATE_LINK"
elif [ -d "$WALLPAPER_DIR" ]; then
  for first in "$WALLPAPER_DIR"/*; do
    [ -f "$first" ] || continue
    WALLPAPER="$first"
    break
  done
fi

[ -f "$WALLPAPER" ] || exit 0
exec "$SET_SCRIPT" "$WALLPAPER"
