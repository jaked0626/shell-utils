#!/bin/bash

# script to compress all pdfs in a given directory 

dir=${1:-$(pwd)}

if [ ! -d "$dir" ]; then
  echo "Error: Directory does not exist"
  exit 1
fi

for file in "$dir"/*.pdf
do
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${file%.*}_compressed.pdf" "$file"
    if [ $? -eq 0 ]; then
        trash "$file"
        echo "Compression successful: $file"
    fi
done
