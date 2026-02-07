#!/bin/sh

if command -v blueman-manager >/dev/null 2>&1; then
	exec blueman-manager
fi

if command -v bluetoothctl >/dev/null 2>&1; then
	exec alacritty -e bluetoothctl
fi

exit 1
