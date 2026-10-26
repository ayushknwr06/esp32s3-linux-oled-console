#!/bin/sh
n=$(( $(date +%s) % 100 + 1 ))
t=0
say() { echo "$1"; echo "$1" > /dev/tty0; }
say "Guess 1-100"
while true; do
  printf "> "
  read g
  case "$g" in ""|*[!0-9]*) say "numbers only"; continue;; esac
  t=$((t+1))
  if [ "$g" -lt "$n" ]; then say "$g: too low"
  elif [ "$g" -gt "$n" ]; then say "$g: too high"
  else say "WIN in $t tries"; break; fi
done
