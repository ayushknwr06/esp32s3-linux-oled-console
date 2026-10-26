#!/bin/sh
printf '\033[2J'
while true; do
  printf '\033[H'
  set -- $(head -2 /proc/meminfo | tail -1)
  echo "Free: $2 kB "
  read up idle < /proc/uptime
  echo "Up: ${up%.*} s "
  read l1 rest < /proc/loadavg
  echo "Load: $l1 "
  sleep 2
done
