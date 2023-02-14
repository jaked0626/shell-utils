#!/bin/bash

# This program moves the n most recently downloaded files on a mac to the specified directory 
# argument 1 is n, argument 2 is the path to move the downloaded files to. 
# if you're like me and you hate moving files after downloading them, this may come in handy. 

# Get the number of most recently downloaded items to move (default 1)
n=${1:-1} 

if ! [[ $n =~ ^[0-9]+$ ]]; then
    echo "Error: the first argument must be an integer"
fi

# Get the destination directory (default current dirctory)
destination_dir=${2:-$(pwd)}

# Check if the destination directory exists
if [ ! -d $destination_dir ]; then
    echo "Error: $destination_dir does not exist."
    exit 1
fi

# Move the n most recently downloaded items to the destination directory
ls -t ~/Downloads | head -$n | while read file; do
    mv ~/Downloads/"$file" $destination_dir
    echo "$file moved to $destination_dir successfully."
done

