#!/bin/sh

if pgrep -u "$UID" -f "polkit.*agent|lxqt-policykit-agent|mate-polkit" >/dev/null 2>&1; then
	exit 0
fi

for agent in \
	/usr/lib/lxqt-policykit/lxqt-policykit-agent \
	/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 \
	/usr/libexec/polkit-gnome-authentication-agent-1 \
	/usr/lib/mate-polkit/polkit-mate-authentication-agent-1
do
	if [ -x "$agent" ]; then
		exec "$agent"
	fi
done

exit 0
