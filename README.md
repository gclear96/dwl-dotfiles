# dotfiles

Local dotfiles repo for this dwl + somebar + someblocks setup.

This is intended for the SceneFX-enabled dwl fork in this workspace.

## somebar
- `somebar/run.sh`: feeds status updates to somebar via its control FIFO
- `somebar/status.sh`: emits status line (cpu/mem/temp/batt/vol/net/date)

## someblocks
- `someblocks/run.sh`: starts someblocks and targets somebar's FIFO
- `tofi/config`: app launcher config (Gruvbox Material Dark Soft)
- `tofi/run.sh`: app launcher entrypoint (tofi-run)
- `tofi/power.sh`: basic power menu (tofi)

## idle + lock + notifications
- `dwl/idle.sh`: starts `swayidle` and calls lock before sleep
- `dwl/lock.sh`: simple `swaylock -f` wrapper
- `swaylock/config`: lock screen theme
- `mako/config`: notification daemon theme

## desktop integration helpers
- `dwl/session-env.sh`: exports/imports session env for portals and starts portal user services
- `dwl/polkit-agent.sh`: starts first available polkit auth agent
- `dwl/cliphist-watch.sh`: starts clipboard history watchers
- `dwl/clipmenu.sh`: clipboard picker + copy
- `dwl/screenshot.sh`: full/area screenshots (grim/slurp + wl-copy)
- `dwl/record.sh`: wf-recorder toggle
- `dwl/volume.sh`: sink/source controls via wpctl
- `dwl/brightness.sh`: brightnessctl wrapper with notifications
- `dwl/media.sh`: playerctl wrapper
- `dwl/battery-notify.sh`: low/critical battery notifications
- `dwl/network.sh`: open network UI (`nm-connection-editor`/`nmtui`)
- `dwl/bluetooth.sh`: open bluetooth UI (`blueman-manager`/`bluetoothctl`)

### Quick start
```
./someblocks/run.sh
```

Make sure you start dwl with `-s "exec somebar </dev/null"` so the FIFO exists.

## Install notes
These scripts assume `somebar` and `someblocks` are installed on `PATH`
(e.g. via `sudo ninja -C build install` for somebar and `sudo make install` for someblocks).

For idle/lock/notifications, install these packages too:
- `swayidle`
- `swaylock`
- `mako`
- optional: `wlopm` (display power off/on on idle)

For full desktop integration, also install:
- `xdg-desktop-portal`
- `xdg-desktop-portal-wlr`
- `xdg-desktop-portal-gtk`
- `lxqt-policykit` or `polkit-gnome`
- `wl-clipboard`, `cliphist`
- `grim`, `slurp`, `wf-recorder`
- `pipewire`, `wireplumber`, `playerctl`
- `brightnessctl`, `upower`
- optional network/bluetooth tools: `networkmanager` (`nmcli`/`nmtui`), `blueman`

Copy configs/scripts to your user config dir:

```sh
mkdir -p ~/.config/dwl ~/.config/mako ~/.config/swaylock
cp dwl/*.sh ~/.config/dwl/
cp mako/config ~/.config/mako/config
cp swaylock/config ~/.config/swaylock/config
chmod +x ~/.config/dwl/*.sh
```

## Tofi
```
tofi-run --config ~/path/to/dotfiles/tofi/config
```
