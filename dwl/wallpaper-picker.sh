#!/bin/sh

set -eu

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"
SET_SCRIPT="$HOME/.config/dwl/set-wallpaper.sh"

if [ ! -d "$WALLPAPER_DIR" ]; then
  exit 0
fi

if [ $# -ge 1 ]; then
  exec "$SET_SCRIPT" "$1"
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT INT TERM

find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' -o -iname '*.gif' \) | sort > "$tmp"
[ -s "$tmp" ] || exit 0

if command -v nsxiv >/dev/null 2>&1; then
  choice="$(nsxiv -otbr -i < "$tmp" | head -n 1)"
  [ -n "${choice:-}" ] || exit 0
  [ -f "$choice" ] || exit 0
  exec "$SET_SCRIPT" "$choice"
fi

choices="$(printf 'Random\n'; sed "s|^$WALLPAPER_DIR/||" "$tmp")"
if command -v tofi >/dev/null 2>&1; then
  choice="$(printf '%s\n' "$choices" | tofi --prompt-text "wallpaper: " --config "$HOME/.config/tofi/config")"
elif command -v wofi >/dev/null 2>&1; then
  choice="$(printf '%s\n' "$choices" | wofi --dmenu --prompt "wallpaper")"
else
  exit 0
fi

[ -n "${choice:-}" ] || exit 0
if [ "$choice" = "Random" ]; then
  wallpaper="$(shuf -n 1 "$tmp")"
else
  wallpaper="$WALLPAPER_DIR/$choice"
fi
[ -f "$wallpaper" ] || exit 0
exec "$SET_SCRIPT" "$wallpaper"
