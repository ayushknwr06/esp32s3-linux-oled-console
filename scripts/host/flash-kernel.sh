#!/usr/bin/env bash
# Flash only the kernel to the linux partition (0x120000). Close picocom first.
# usage: flash-kernel.sh [port] [image]
set -euo pipefail
source "$(dirname "$0")/env.sh"
LIMIT=3538944
PORT=${1:-/dev/ttyACM0}
IMG=${2:-$O/images/xipImage}
SIZE=$(stat -c %s "$IMG")
[ "$SIZE" -le "$LIMIT" ] || { echo "Refusing to flash: $SIZE > $LIMIT"; exit 1; }
esptool.py --chip esp32s3 -p "$PORT" -b 460800 write_flash 0x120000 "$IMG"
