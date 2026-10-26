# USB keyboard

The kernel source already describes the ESP32-S3 USB controller (`esp32s3.dtsi`) and `esp32s3-devkit-c1.dts` sets `dr_mode = "host"`. Only the kernel config needed changing, see `configs/kernel-options.md`.

## What works
`dmesg` shows `dwc2 60080000.usb: DWC OTG Controller`, a root hub with 1 port, `usbhid`, and the keyboard dongle registered as an input device.

## Power
The board does not appear to switch 5 V to the host connector (nothing in the device tree). The dongle needs 5 V from outside. With no power, `HPRT0` in the controller registers read `0x00001000` (port powered, nothing connected) and `/sys/bus/usb/devices` listed only `usb1` and `1-0:1.0`.

Check the controller at any time:

```bash
mount -t debugfs none /sys/kernel/debug
cat /sys/kernel/debug/usb/60080000.usb/regdump | grep -E "HPRT0|HCFG"
```

## Login on the OLED
The OLED login comes from a `getty` on `tty1`. See `scripts/board/S99oled` and `docs/boot-fix.md`.

The native USB serial port stops working in host mode, so use the UART port for the PC console.
