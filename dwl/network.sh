#!/bin/sh

if command -v nm-connection-editor >/dev/null 2>&1; then
	exec nm-connection-editor
fi

if command -v nmtui >/dev/null 2>&1; then
	exec alacritty -e nmtui
fi

exit 1
