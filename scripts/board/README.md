# Scripts for the board (BusyBox sh)

The board has no file transfer yet. Type or paste each file over the serial console with a heredoc, or use `vi`:

```sh
cat > /etc/clock.sh << 'EOF'
...paste the file here...
EOF
chmod +x /etc/clock.sh
sync
```

If lines arrive garbled, paste smaller pieces. `/etc` is writable flash (about 232 KB free) and survives power loss; `/tmp` may not be writable.

| File | Purpose | Tested |
|---|---|---|
| `S99oled` | boot script: makes init start the OLED login | yes |
| `S99quiet` | boot script: quiet the console (`dmesg -n 1`) | no |
| `clock.sh` | clock on the OLED | no |
| `sys.sh` | free RAM, uptime, load | no |
| `mem.sh` | RAM and storage summary | no |
| `guess.sh` | number guessing game | no |
| `mul_oled.sh` | multiply two numbers, output on shell and OLED | no |
| `temp.sh` | CPU temperature, needs a thermal driver | no |

Also add this line to `/etc/inittab` (backup it first with `cp /etc/inittab /etc/inittab.bak`):

```
tty1::respawn:/sbin/getty -L tty1 0 linux
```

The clock is wrong at every boot (no RTC): `date -s "YYYY-MM-DD HH:MM:SS"`.
