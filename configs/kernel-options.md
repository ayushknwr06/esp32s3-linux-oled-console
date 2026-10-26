# Kernel options changed

Edit with `make O=$O linux-menuconfig` (search with `/`).

| Option | Value | Purpose |
|---|---|---|
| FB | y | frame buffer support |
| FB_SSD1307 | y | OLED driver |
| VT, VT_CONSOLE | y | virtual terminals |
| FRAMEBUFFER_CONSOLE | y | text console on the OLED |
| FONT_8x8 | y | 16 by 8 characters |
| IPV6, MPLS | n | make room (kernel fit its partition) |
| INET | y | required by the Wi-Fi driver, keep on |
| GENERIC_PHY, PHY_ESP32S3_USB | y | USB PHY |
| USB_SUPPORT, USB | y | USB core |
| USB_DWC2 (host only) | y | USB host controller |
| USB_HID | y | keyboard |

Size gate: `xipImage` must be 3,538,944 bytes or less. With the USB host options it was 3,524,904 bytes, which leaves about 14 KB.

Kernel command line (`arch/xtensa/boot/dts/esp32s3.dtsi`, line 11): `console=tty0 console=ttyS0,115200n8` in the `bootargs`.
