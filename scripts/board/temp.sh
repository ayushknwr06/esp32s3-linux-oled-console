#!/bin/sh
# Needs a thermal driver. Check first: ls /sys/class/thermal /sys/class/hwmon
Z=/sys/class/thermal/thermal_zone0/temp
printf '\033[2J'
while true; do
  read t < $Z
  printf '\033[H'
  echo "CPU temp        "
  echo "$((t/1000)).$(((t%1000)/100)) C      "
  sleep 2
done
