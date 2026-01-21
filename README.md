# dotfiles

Local dotfiles repo for this dwl + dwlb setup.

## dwlb
- `dwlb/run.sh`: launches dwlb with IPC + status stdin
- `dwlb/status.sh`: emits status line (cpu/mem/temp/batt/vol/net/date)
- `tofi/config`: app launcher config (Gruvbox Material Dark Soft)

### Quick start
```
./dwlb/run.sh
```

Set `DWLB_OUTPUT` if your output name is not `eDP-1`.

## Tofi
```
tofi-run --config ~/path/to/dotfiles/tofi/config
```
