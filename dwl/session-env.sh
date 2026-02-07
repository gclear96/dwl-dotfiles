#!/bin/sh

export XDG_CURRENT_DESKTOP="${XDG_CURRENT_DESKTOP:-dwl}"
export XDG_SESSION_DESKTOP="${XDG_SESSION_DESKTOP:-dwl}"
export XDG_SESSION_TYPE="${XDG_SESSION_TYPE:-wayland}"

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
	dbus-update-activation-environment --systemd \
		WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE \
		>/dev/null 2>&1
fi

if command -v systemctl >/dev/null 2>&1; then
	systemctl --user import-environment \
		WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE \
		>/dev/null 2>&1

	systemctl --user start xdg-desktop-portal.service >/dev/null 2>&1 || true
	systemctl --user start xdg-desktop-portal-wlr.service >/dev/null 2>&1 || true
	systemctl --user start xdg-desktop-portal-gtk.service >/dev/null 2>&1 || true
fi
