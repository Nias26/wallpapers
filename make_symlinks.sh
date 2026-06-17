#!/usr/bin/env bash
set -euo pipefail
NORM_DIR="./normal"
ALL_DIR="./all"

find "$NORM_DIR" -type f | while IFS= read -r src; do
  rel="${src#$NORM_DIR/}"
  dest_dir="${ALL_DIR}/$(dirname "$rel")"
  ln -sf "../../${src#*/}" "$dest_dir/$(basename "$rel")"
done
