#!/bin/sh
while read k v u; do case $k in MemTotal:) t=$v;; MemFree:) f=$v;; esac; done < /proc/meminfo
echo "RAM T:$t"
echo "RAM F:$f"
echo "RAM U:$((t-f))"
df -k /etc | tail -1 | while read a b c d e g; do echo "etc U:$c"; echo "etc F:$d"; done
