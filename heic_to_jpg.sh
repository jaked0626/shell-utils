#!/bin/bash

# Converts heic files to jpeg. Needed it to add photos that I took 
# on my iphone to my website. 

# Check if the "convert" command is available
if ! [ -x "$(command -v convert)" ]; then
  echo "Error: convert command not found. Please install the ImageMagick package." >&2
  exit 1
fi

# Get the directory containing the HEIC files
if [ -z "$1" ]; then
  echo "Usage: $0 DIRECTORY" >&2
  exit 1
else
  dir=$1
fi

# Convert all HEIC files to JPG
for file in "$dir"/*.HEIC; do
  convert "$file" "${file%.HEIC}.jpg"
done
