#!/bin/sh

set -eu

if ! command -v wbg >/dev/null 2>&1; then
  exit 0
fi

WALLPAPER="${1:-}"
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/dwl"
STATE_LINK="$STATE_DIR/current-wallpaper"

if [ -z "$WALLPAPER" ] && [ -d "$WALLPAPER_DIR" ]; then
  for first in "$WALLPAPER_DIR"/*; do
    [ -f "$first" ] || continue
    WALLPAPER="$first"
    break
  done
fi

[ -n "$WALLPAPER" ] || exit 0
[ -f "$WALLPAPER" ] || exit 0

mkdir -p "$STATE_DIR"
ln -sfn "$WALLPAPER" "$STATE_LINK"

if [ -x "$HOME/.config/dwl/matugen-theme.sh" ]; then
  "$HOME/.config/dwl/matugen-theme.sh" "$WALLPAPER" >/dev/null 2>&1 &
fi

wbg "$WALLPAPER" >/dev/null 2>&1 &
