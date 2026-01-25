# dotfiles

Local dotfiles repo for this dwl + somebar + someblocks setup.

## somebar
- `somebar/run.sh`: feeds status updates to somebar via its control FIFO
- `somebar/status.sh`: emits status line (cpu/mem/temp/batt/vol/net/date)

## someblocks
- `someblocks/run.sh`: starts someblocks and targets somebar's FIFO
- `tofi/config`: app launcher config (Gruvbox Material Dark Soft)
- `tofi/run.sh`: app launcher entrypoint (tofi-run)
- `tofi/power.sh`: basic power menu (tofi)

### Quick start
```
./someblocks/run.sh
```

Make sure you start dwl with `-s somebar` so the FIFO exists.

## Install notes
These scripts assume `somebar` and `someblocks` are installed on `PATH`
(e.g. via `sudo ninja -C build install` for somebar and `sudo make install` for someblocks).

## Tofi
```
tofi-run --config ~/path/to/dotfiles/tofi/config
```
