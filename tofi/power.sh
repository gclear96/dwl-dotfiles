#!/bin/sh

CONFIG="$HOME/.config/tofi/config"

choice=$(printf "Lock\nSuspend\nReboot\nShutdown\nLogout\n" | tofi --prompt-text "power: " --config "$CONFIG")

case "$choice" in
	Lock)
		command -v loginctl >/dev/null 2>&1 && loginctl lock-session
		;;
	Suspend)
		systemctl suspend
		;;
	Reboot)
		systemctl reboot
		;;
	Shutdown)
		systemctl poweroff
		;;
	Logout)
		loginctl terminate-user "$USER"
		;;
esac
