#!/bin/sh

CONFIG="$HOME/.config/tofi/config"

choice=$(printf "Lock\nSuspend\nReboot\nShutdown\nLogout\n" | tofi --prompt-text "power: " --config "$CONFIG")

case "$choice" in
	Lock)
		if [ -x "$HOME/.config/dwl/lock.sh" ]; then
			"$HOME/.config/dwl/lock.sh"
		elif command -v loginctl >/dev/null 2>&1; then
			loginctl lock-session
		fi
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
