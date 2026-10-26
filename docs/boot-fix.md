# Why the OLED login needed `kill -HUP 1`

The root filesystem is a read-only cramfs. `/etc` is a separate writable jffs2 partition mounted by `::sysinit:/bin/mount -a`. init reads `/etc/inittab` from the read-only root before that mount happens, so a `tty1` line added to the flash copy of `inittab` is not seen at boot. `kill -HUP 1` makes init read it again after `/etc` is mounted.

Fix: a boot script that sends the HUP itself.

```sh
#!/bin/sh
case "$1" in
  start) kill -HUP 1 ;;
esac
```

Install it as `/etc/init.d/S99oled` (see `scripts/board/S99oled`) and add this line to `/etc/inittab`:

```
tty1::respawn:/sbin/getty -L tty1 0 linux
```

A cleaner fix is to put the line in the root filesystem's own `inittab` with a Buildroot overlay and rebuild the rootfs.
