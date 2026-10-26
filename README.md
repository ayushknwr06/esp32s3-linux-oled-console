# Linux on an ESP32-S3 (N16R8) with an OLED console and USB keyboard

Notes, scripts and config for booting **Linux 6.11 (Buildroot, no MMU)** on an ESP32-S3, showing the terminal on a 0.96" SSD1306 OLED and typing on a wireless USB keyboard, with no PC needed after boot.

It builds on the open-source [esp32-linux-build](https://github.com/jcmvbkbc/esp32-linux-build) project (Linux port for ESP32 chips by jcmvbkbc). This repository contains only my notes, helper scripts and small config changes. Nothing from the upstream project is copied here, and it keeps its own licenses.

## Hardware

| Part | Notes |
|---|---|
| ESP32-S3 N16R8 dev board | 16 MB flash, 8 MB octal PSRAM, two USB-C ports (UART and native USB) |
| 0.96" OLED, SSD1306, I2C, 128x64 | Address `0x3c`, wired to GPIO6 (SDA) and GPIO7 (SCL), 3V3 and GND |
| 2.4 GHz wireless keyboard dongle | USB host on the native USB pins (GPIO19 D-, GPIO20 D+); dongle needs 5 V |
| Ubuntu PC | Build host, flashing, serial console while developing |

> TODO (author): describe exactly how the dongle gets 5 V in your build, and add photos to `docs/images/`.

## Status

| Feature | Status |
|---|---|
| Linux 6.11.0 boots to a Buildroot shell | Verified |
| Serial console on the UART USB-C port | Verified |
| OLED shows the boot console (`ssd1307fb` + fbcon) | Verified (needed a mirror fix) |
| OLED login prompt at boot without a PC | Verified (needs `S99oled`) |
| USB host (`dwc2`, hub, HID) | Verified in `dmesg` |
| Wireless keyboard dongle detected | Verified in `dmesg` |
| Typing at the OLED login | Reported working by the author |
| I2C tools on `/dev/i2c-0` | Verified (`i2cdetect` shows `3c`) |
| Wi-Fi (ESP-Hosted) | Not working yet: `wpa_supplicant` starts, auth requests fail |
| Shell apps in `scripts/board/` | Written, not all tested |
| Internal CPU temperature | Unknown, needs a thermal driver |
| Built-in RGB LED | Not supported (needs a WS2812 driver) |
| Second display | Not done, see `docs/roadmap.md` |
| Mouse | Detected, unused |

## Measured on the board

| Item | Value |
|---|---|
| Kernel | Linux 6.11.0, no MMU, PREEMPT |
| CPU | 1 core visible to Linux, Xtensa LX7, 240 MHz |
| RAM | 7304 to 7320 kB total (8 MB PSRAM), about 1.5 MB free after boot |
| Flash | 16 MB chip, partition table ends at 8 MB (`0x800000`) |
| Kernel partition | `0x360000` = 3,538,944 bytes |
| Kernel sizes | original 3,535,304; OLED console 3,345,704; with USB host 3,524,904 |
| Writable storage | `/etc` (jffs2), 448 KB, about 232 KB free |
| Boot (kernel time to init) | 4.3 s on the first kernel; 20 to 35 s with `console=tty0` (printing to the OLED is slow) |

## Quick start

1. Build everything once, see [docs/build-guide.md](docs/build-guide.md).
2. Source the environment before any kernel work: `source scripts/host/env.sh`.
3. Rebuild the kernel and check its size: `scripts/host/rebuild-kernel.sh`.
4. Flash only the kernel: `scripts/host/flash-kernel.sh`.
5. Open the console on the **UART** port: `picocom -b 115200 /dev/ttyACM0`.
6. Install the boot script and apps, see [scripts/board/README.md](scripts/board/README.md).

## Repository layout

```
docs/       build guide, troubleshooting, OLED console, USB keyboard, roadmap
configs/    kernel options and the device-tree node
scripts/    host/ (PC side) and board/ (run on the ESP32-S3)
```

## Problems solved

See [docs/troubleshooting.md](docs/troubleshooting.md) for the full table. In short: GCC 15 and CMake 4 break the old toolchain sources, the kernel must fit its 3.5 MB partition, TCP/IP must stay on for the Wi-Fi driver, and init reads `inittab` before `/etc` is mounted.

## Limits

No MMU (no `fork()`, only no-MMU programs), one core visible to Linux, about 1.5 MB free RAM, IPv6 disabled to make room, a 16 by 8 character screen.

## Credits and license

Upstream project: [jcmvbkbc/esp32-linux-build](https://github.com/jcmvbkbc/esp32-linux-build) (please check the author name and licenses on that page). This repository is MIT licensed, see `LICENSE`.
