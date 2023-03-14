#!/bin/bash

read -p 'name of file to compress: ' mov_file

# get full path of file 

dirpath=$(pwd);
full_mov_file=$dirpath'/'$mov_file;

new_file=${full_mov_file/%.mov/_compressed.mov};
#echo $full_mov_file;
#echo $new_file;
ffmpeg -i $full_mov_file -c:v libx264 -c:a copy -crf 20 $new_file;
if test -f "$new_file"; then
    echo "compression successful, see $new_file for compressed video";
    mv $full_mov_file ~/.Trash/;
else
    echo 'compression failed';
fi


