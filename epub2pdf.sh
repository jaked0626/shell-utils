#!/bin/bash

# The file takes either a directory or file path as an argument and converts 
# the input files to pdf format. Works for epub and modi files. Assumes 
# you are using macOS. Requires epub-tools. 

# Function to display usage information
usage() {
  echo "This command converts epubs of the file type *.epub to pdfs (mobi not supported currently)"
  echo "Usage: ./epub2pdf.sh [OPTIONS] [epub file/directory]"
  echo "OPTIONS:"
  echo "  -h, --help       Display this help and exit"
}

# Check if the user requested help
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  usage
  exit
fi

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
  echo "pandoc could not be found. Installing pandoc"
  brew install pandoc
  exit
fi

path=${1:-./}

# Initialize an empty array to hold the epub files
epub_files=()

# Add epub files to array
if [ -d $path ]; then
  files=()
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find -E "$path" -regex '.*\.epub$' -print0)
  for file in "${files[@]}"; do
    if [ -e "$file" ]; then
      epub_files+=("$file")
    fi
  done
elif [ -f $path]; then
  # Input is a file. Check if the file is MOBI or EPUB.
  if [[ $path == *.epub ]]; then
    epub_files+=("$path")
  else
    echo "Invalid input. The file must be EPUB."
    exit
  fi
else
  echo "Invalid input. The file must be EPUB."
  echo "For more information on how to use this command, run"
  echo "epub2pdf.sh -h"
fi

# Check if there are any epub files in the array
if [ ${#epub_files[@]} -eq 0 ]
then
    echo "No epub files found in the input."
    exit
fi

# Convert each epub file in the array to PDF
echo "Converting epub files to PDF..."
for file in "${epub_files[@]}"; do
  output_file="${file%.*}.pdf"
  pandoc -f epub "$file" -o "$output_file"
  if [ -e "$output_file" ]; then
    echo -e "$file \n \t -> $output_file"
  fi
done

echo "Program run successfully"


