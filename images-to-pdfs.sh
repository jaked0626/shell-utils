#!/usr/bin/env bash
set -euo pipefail

DIR="${1:-.}"
COMBINED="combined.pdf"
TARGET_DPI="300dpi"

# 1. Find all PNG/JPG images and embed them at 300 DPI (> 200 DPI)
find "$DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -print0 |
  sort -z |
  xargs -0 img2pdf --imgsize "$TARGET_DPI" -o "$COMBINED"

# 2. Split each page of the combined PDF into separate PDF files
pdfseparate "$COMBINED" "page_%d.pdf"

echo "Done! Created $COMBINED at $TARGET_DPI and split it into page_*.pdf files."

