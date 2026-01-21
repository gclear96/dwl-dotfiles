#!/bin/sh

# Simple status generator for dwlb.
# Override via env: INTERVAL, SHOW_* toggles (1/0).

INTERVAL="${INTERVAL:-5}"
SHOW_CPU="${SHOW_CPU:-1}"
SHOW_MEM="${SHOW_MEM:-1}"
SHOW_TEMP="${SHOW_TEMP:-1}"
SHOW_BATT="${SHOW_BATT:-1}"
SHOW_VOL="${SHOW_VOL:-1}"
SHOW_NET="${SHOW_NET:-1}"
SHOW_DATE="${SHOW_DATE:-1}"

cpu_file="/tmp/dwlb_cpu"

cpu_usage() {
	if [ ! -r /proc/stat ]; then
		return
	fi
	read -r _ u n s i w irq sirq st _ < /proc/stat
	idle=$((i + w))
	total=$((u + n + s + idle + irq + sirq + st))
	if [ -f "$cpu_file" ]; then
		read -r p_idle p_total < "$cpu_file"
		delta_idle=$((idle - p_idle))
		delta_total=$((total - p_total))
		if [ "$delta_total" -gt 0 ]; then
			usage=$(( (100 * (delta_total - delta_idle)) / delta_total ))
			printf "%s" "$usage%"
		fi
	fi
	printf "%s %s\n" "$idle" "$total" > "$cpu_file"
}

mem_usage() {
	if command -v free >/dev/null 2>&1; then
		free -h | awk '/Mem:/ {printf "%s/%s", $3, $2}'
	fi
}

temp_read() {
	for z in /sys/class/thermal/thermal_zone*/temp; do
		[ -r "$z" ] || continue
		v=$(cat "$z" 2>/dev/null)
		case "$v" in
			"" ) continue;;
			* ) printf "%.1fC" "$(awk "BEGIN {print $v/1000}")"; return;;
		esac
	done
}

batt_read() {
	for b in /sys/class/power_supply/BAT*; do
		[ -r "$b/capacity" ] || continue
		cap=$(cat "$b/capacity" 2>/dev/null)
		stat=$(cat "$b/status" 2>/dev/null)
		[ -n "$cap" ] && printf "%s%%" "$cap" && [ -n "$stat" ] && printf " %s" "$stat"
		return
	done
}

vol_read() {
	if command -v wpctl >/dev/null 2>&1; then
		vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print $2}')
		mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print $3}')
		if [ -n "$vol" ]; then
			pct=$(awk "BEGIN {printf \"%d\", $vol*100}")
			if [ "$mute" = "[MUTED]" ]; then
				printf "%s%% M" "$pct"
			else
				printf "%s%%" "$pct"
			fi
		fi
	fi
}

net_read() {
	if command -v ip >/dev/null 2>&1; then
		iface=$(ip route 2>/dev/null | awk '/^default/ {print $5; exit}')
		if [ -n "$iface" ] && [ -r "/sys/class/net/$iface/operstate" ]; then
			state=$(cat "/sys/class/net/$iface/operstate" 2>/dev/null)
			printf "%s:%s" "$iface" "$state"
		fi
	fi
}

while true; do
	out=""
	if [ "$SHOW_CPU" = "1" ]; then
		cpu=$(cpu_usage)
		[ -n "$cpu" ] && out="$out[ CPU:$cpu ] "
	fi
	if [ "$SHOW_MEM" = "1" ]; then
		mem=$(mem_usage)
		[ -n "$mem" ] && out="$out[ Mem:$mem ] "
	fi
	if [ "$SHOW_TEMP" = "1" ]; then
		tmp=$(temp_read)
		[ -n "$tmp" ] && out="$out[ Temp:$tmp ] "
	fi
	if [ "$SHOW_BATT" = "1" ]; then
		bat=$(batt_read)
		[ -n "$bat" ] && out="$out[ Bat:$bat ] "
	fi
	if [ "$SHOW_VOL" = "1" ]; then
		vol=$(vol_read)
		[ -n "$vol" ] && out="$out[ Vol:$vol ] "
	fi
	if [ "$SHOW_NET" = "1" ]; then
		net=$(net_read)
		[ -n "$net" ] && out="$out[ Net:$net ] "
	fi
	if [ "$SHOW_DATE" = "1" ]; then
		out="$out[ $(date "+%b %d (%a) %I:%M%p") ]"
	fi
	printf "%s\n" "$out"
	sleep "$INTERVAL"
done
