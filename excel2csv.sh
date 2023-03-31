#!/bin/bash

# this script converts all excel files in a give directory to csv files. 
# must have pip installed on system to work. 

# Specify the directory where the xls/xlsx files are located
directory=${1:-./}

# Check if xlsx2csv is installed
if ! command -v xlsx2csv &> /dev/null; then
  # xlsx2csv is not installed, install it using pip
  echo "xlsx2csv is not installed, installing it now..."
  pip3 install xlsx2csv
fi

# Check if unoconv is installed
if ! command -v unoconv &> /dev/null; then
  # unoconv is not installed, install it using apt-get (for Ubuntu/Debian-based systems)
  echo "unoconv is not installed, installing it now..."
  brew install unoconv
fi

# Create directory to store csv files
mkdir "$directory/csv_files"

# Loop through all xls and xlsx files in the directory
for file in "$directory"/*.xls*; do
  if [[ "$file" == *.xls ]]; then
    # Convert the xls file to xlsx format using unoconv
    unoconv -f xlsx "$file"
    # Update the file variable to point to the new xlsx file
    file="${file%xls}xlsx"
  fi
  # Convert the file to csv using xlsx2csv tool
  xlsx2csv "$file" "./csv_files/${file%.*}.csv"
  echo "Converted $file to csv"
done

echo "Conversion complete!"
