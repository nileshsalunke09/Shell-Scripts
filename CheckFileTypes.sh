#!/bin/bash


# loop & print a folder recusively,
print_folder_recurse() {
    for i in "$1"/*;do
        if [ -d "$i" ];then
		local temp=$i
        	print_folder_recurse "$temp"
        elif [ -f "$i" ]; then
		name="${1##*/}"
        	size=$(stat -c%b "$1")
		type="$(file -b --mime-type $i)"
		if [ "${file[$type]}" ]; 
        	then
          		(( file[$type]++ ))
          		(( size[$type]+=$size ))
        	else
          		file[$type]=1
          		size[$type]=$size
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
do
  printf '%s Files \t|%d|\t%d KB\n' "$i" "${file[$i]}" "${size[$i]}"
done
