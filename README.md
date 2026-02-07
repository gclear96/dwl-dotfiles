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

Copy configs/scripts to your user config dir:

```sh
mkdir -p ~/.config/dwl ~/.config/mako ~/.config/swaylock
cp dwl/idle.sh ~/.config/dwl/idle.sh
cp dwl/lock.sh ~/.config/dwl/lock.sh
cp mako/config ~/.config/mako/config
cp swaylock/config ~/.config/swaylock/config
chmod +x ~/.config/dwl/idle.sh ~/.config/dwl/lock.sh
```

## Tofi
```
tofi-run --config ~/path/to/dotfiles/tofi/config
```
