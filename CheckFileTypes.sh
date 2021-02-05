#!/bin/bash


# loop & print a folder recusively,
print_folder_recurse() {
    for i in "$1"/*;do
        if [ -d "$i" ];then
                local temp=$i
                print_folder_recurse "$temp"
        elif [ -f "$i" ]; then
                filename="${1##*/}"
                extension="${1##*.}"
                filesize=$(stat -c%b "$1")
                if [ "${file[$extension]}" ];
                then
                        (( file[$extension]++ ))
                        (( size[$extension]+=$filesize ))
                else
                        file[$extension]=1
                        size[$extension]=$filesize
                fi
        fi
    done
}


declare -A file
declare -A size

file[txt]=0
size[html]=0


# try get path from param
path=""
if [ -d "$1" ]; then
    path=$1;
else
    path="/tmp"
fi

echo "base path: $path"
print_folder_recurse $path

for i in "${!file[@]}";
