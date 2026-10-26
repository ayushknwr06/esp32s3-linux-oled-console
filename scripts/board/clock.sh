#!/bin/sh
printf '\033[2J'
while true; do
  printf '\033[H'
  echo "$(date +%H:%M:%S)"
  echo "$(date +%d-%m-%Y)"
  sleep 1
done
