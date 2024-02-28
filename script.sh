#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 folder_path file_list.txt found_files.txt"
    exit 1
fi

folder_path="$1"
file_list="$2"
found_files="$3"
not_found_files="not_found_files.txt"

# Check if the folder exists
if [ ! -d "$folder_path" ]; then
    echo "Error: Folder not found"
    exit 1
fi

# Check if the file list exists
if [ ! -e "$file_list" ]; then
    echo "Error: File list not found"
    exit 1
fi

# Create an empty file for found and not found files
> "$found_files"
> "$not_found_files"

# Iterate through each file in the list and search in the folder
while IFS= read -r filename; do
    if [ -e "$folder_path/$filename" ]; then
        echo "File '$filename' found in '$folder_path'"
        echo "$filename" >> "$found_files"
    else
        echo "File '$filename' not found in '$folder_path'"
        echo "$filename" >> "$not_found_files"
    fi
done < "$file_list"
