#!/bin/sh
say() { echo "$1"; echo "$1" > /dev/tty0; }
ask() { printf "%s" "$1"; printf "%s" "$1" > /dev/tty0; }
say "Multiply (q=quit)"
while true; do
  ask "A: "; read a
  [ "$a" = "q" ] && break
  echo "$a" > /dev/tty0
  ask "B: "; read b
  echo "$b" > /dev/tty0
  case "$a$b" in *[!0-9-]*|"") say "numbers only"; continue;; esac
  say "= $((a * b))"
done
say "bye"
