#!/usr/bin/env bash
# Rebuild only the kernel and check that it fits the linux partition. Does not flash.
set -uo pipefail
source "$(dirname "$0")/env.sh"
LIMIT=3538944
cd ~/esp32-linux-build/build/buildroot
make O="$O" linux-rebuild 2>&1 | tee ~/kbuild.log | tail -3
if grep -q "\*\*\*" ~/kbuild.log; then
  echo "Build failed. Real errors:"; grep -n -E "Error|error:|undefined reference" ~/kbuild.log | head
  exit 1
fi
SIZE=$(stat -c %s "$O/images/xipImage")
echo "xipImage: $SIZE bytes (limit $LIMIT)"
[ "$SIZE" -le "$LIMIT" ] || { echo "Too big for the linux partition. Do not flash."; exit 1; }
