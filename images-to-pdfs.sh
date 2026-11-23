#!/usr/bin/env bash
set -euo pipefail

DIR="${1:-.}"
COMBINED="combined.pdf"

# 1. Find all PNG/JPG images (remove '-maxdepth 1' to search subdirectories)
#    and combine them into a single multi-page PDF
find "$DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) -print0 |
  sort -z |
  xargs -0 img2pdf -o "$COMBINED"

# 2. Split each page of the combined PDF into separate PDF files
pdfseparate "$COMBINED" "page_%d.pdf"

echo "Done! Created $COMBINED and split it into individual page_*.pdf files."
