# Build guide (Ubuntu host)

Everything here was run on Ubuntu with GCC 15.2 and CMake 4. A full build takes 1 to 2 hours and needs 10 GB or more of free disk.

## 1. Host packages and sources

```bash
sudo apt install -y build-essential gperf bison flex texinfo help2man gawk libtool-bin automake libncurses-dev python3 python3-pip python3-venv wget unzip cmake ninja-build libusb-1.0-0 rsync bc cpio libssl-dev xz-utils patch
pip3 install esptool
sudo usermod -aG dialout $USER      # log out and back in afterwards
git clone https://github.com/jcmvbkbc/esp32-linux-build.git
```

## 2. Work around newer tools

GCC 15 (C23 defaults) breaks the old GMP source, and CMake 4 rejects very old projects. Run `scripts/host/setup-oldgcc.sh` once, then in every terminal:

```bash
source scripts/host/env.sh
```

## 3. Build and flash

```bash
cd ~/esp32-linux-build
./rebuild-esp32s3-linux-wifi.sh
```

The script builds the toolchain, kernel, root filesystem and the Wi-Fi firmware, flashes them, and writes the kernel and rootfs by partition name. Do not rerun it later: it can overwrite your kernel config. For kernel-only changes use `scripts/host/rebuild-kernel.sh` instead.

## 4. Open the console

Use the **UART** USB-C port (the chip shows up as `/dev/ttyACM0`):

```bash
sudo chmod 666 /dev/ttyACM0
picocom -b 115200 /dev/ttyACM0
```

Exit picocom with Ctrl-A, then Ctrl-X. Log in as `root`. The native USB port drops on every reset, so it loses the early boot text.

## Partition layout (8 MB table)

| Partition | Offset | Size |
|---|---|---|
| nvs | 0xa000 | 0x5000 |
| phy_init | 0xf000 | 0x1000 |
| factory (Wi-Fi firmware) | 0x10000 | 0xa0000 |
| etc (writable jffs2) | 0xb0000 | 0x70000 |
| linux (kernel) | 0x120000 | 0x360000 |
| rootfs (cramfs) | 0x480000 | 0x380000 |

A 16 MB table (`partition_table.esp32s3.16m`, `linux` = 0x4e0000, `rootfs` at 0x600000) ships with the upstream project. Its matching config also switches PSRAM to 16 MB, which the N16R8 does not have, so copy the 8 MB config and change only the flash size and table name.
