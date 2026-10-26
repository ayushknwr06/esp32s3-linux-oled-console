# Roadmap and ideas

- **RTC (DS3231 at 0x68)** to keep the time across power loss. A boot script can read it with `i2cget`.
- **Second OLED.** Two modules both at `0x3c` need a changed address (`0x3d`) or a second I2C bus. A second `ssd1307fb` node gives `/dev/fb1`; fbcon only draws the active console, so two simultaneous terminals are not expected. Alternatively drive it from scripts with `i2ctransfer`.
- **Sensors on the same I2C bus:** AHT20, SHT31, BME280, INA219.
- **GPIO parts** through sysfs (`/sys/class/gpio`, base `576` plus the GPIO number, unconfirmed for all pins): LED, button, buzzer.
- **Built-in RGB LED (likely WS2812):** needs a kernel driver.
- **CPU temperature:** needs a thermal or hwmon driver, check `/sys/class/thermal`.
- **Wi-Fi:** find the `wpa_supplicant` config and fix the failing auth requests, then NTP time sync.
- **16 MB partition layout** for room to grow the kernel, plus USB storage.
- Set a root password before connecting the board to any network.
