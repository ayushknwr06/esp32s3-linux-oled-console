# OLED console

## Why not the DRM driver
`DRM_SSD130X` depends on `MMU`, so it cannot be used on this kernel. The older framebuffer driver `ssd1307fb` (`FB_SSD1307`) works instead.

## Wiring

| OLED | ESP32-S3 |
|---|---|
| VCC | 3V3 |
| GND | GND |
| SDA | GPIO6 |
| SCL | GPIO7 |

The bus is a software I2C bus (`i2c-gpio`, `/dev/i2c-0`). `i2cdetect -y 0` should show `3c` before the driver takes the address.

## Kernel options and device tree

See `configs/kernel-options.md` and `configs/dts/oled-node.dts`. The node goes inside the existing `i2c0 { ... };` block of `esp32s3-devkit-c1.dts`.

## Behaviour

- The screen is a 16 by 8 text grid with the 8x8 font.
- `console=tty0` sends kernel messages to the OLED, but each line is drawn over slow software I2C, so boot takes much longer (20 to 35 s kernel time to init, against 4.3 s without). Remove `console=tty0` to keep only the login on the OLED (untested).
- Anything written to `/dev/tty0` shows on the active console.
- If the display goes blank or shows NAK errors after a reset, unplug USB completely for a few seconds.
