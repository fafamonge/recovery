#!/bin/bash
set -euo pipefail

echo "Running shell syntax checks..."

for f in install.sh uninstall.sh bin/*; do
  [ -f "$f" ] || continue
  echo "checking $f"
  bash -n "$f"
done

echo "OK"
