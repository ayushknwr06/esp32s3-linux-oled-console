# Troubleshooting

| # | Symptom | Cause | Fix |
|---|---|---|---|
| 1 | GMP: `could not find a working compiler` | GCC 15 uses C23, old GMP breaks | Put gcc-13 first in `PATH` (`setup-oldgcc.sh`) |
| 2 | host-lzo: `Compatibility with CMake < 3.5 has been removed` | CMake 4 | `export CMAKE_POLICY_VERSION_MINIMUM=3.5` |
| 3 | `Permission denied: /dev/ttyACM0` | Not in `dialout` | `sudo chmod 666 /dev/ttyACM0`, or `usermod -aG dialout` and log in again |
| 4 | `picocom: command not found` | Not installed | `sudo apt install picocom` |
| 5 | `read zero bytes from port` | Native USB resets on boot | Use the UART USB-C port |
| 6 | No `/dev/ttyUSB0` | The UART chip appears as `ttyACM0` | Open `/dev/ttyACM0` |
| 7 | Kernel too big: 3,631,944 B vs 3,538,944 B partition | Display and console drivers added | Turn IPv6 and MPLS off: 3,345,704 B |
| 8 | Link error: `undefined reference to register_inetaddr_notifier` | `CONFIG_INET` turned off | Keep `CONFIG_INET=y`, the Wi-Fi driver needs it |
| 9 | Assembler errors: unknown opcode `ld.qr`, invalid register `atomctl` | `XTENSA_GNU_CONFIG` not set in this shell | `source scripts/host/env.sh` |
| 10 | `i2c i2c-0: sendbytes: NAK bailout` | OLED I2C chip stuck after a reset, or loose wire | Unplug USB for 5 s; check wiring |
| 11 | Mirrored OLED text | Segment remap default | Add `solomon,segment-no-remap;` to the OLED node |
| 12 | OLED login appears only after `kill -HUP 1` | init read `inittab` before `/etc` was mounted | Install `scripts/board/S99oled` |

## Tips

- Find the real error in a build log by searching for `Error` with a capital E, not only `error:`.
- A build that ends with `Error` leaves the old `xipImage` in place; its size is not the new kernel's.
- Typing `if config -a` (with a space) starts a shell `if` and leaves you at a `>` prompt. Press Ctrl-C.
