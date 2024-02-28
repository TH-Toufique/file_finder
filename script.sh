#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 folder_path file_list.txt output_found.txt"
    exit 1
fi

folder_path="$1"
file_list="$2"
output_found="$3"

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

# Flag to check if any file is not found
not_found_flag=false

# Create an empty output file
> "$output_found"

# Iterate through each file in the list and search in the folder
while IFS= read -r filename; do
    if [ -e "$folder_path/$filename" ]; then
        echo "File '$filename' found in '$folder_path'"
        echo "$filename" >> "$output_found"
    else
        echo "File '$filename' not found in '$folder_path' <<< NOT FOUND"
        not_found_flag=true
    fi
done < "$file_list"

# Exit with a non-zero status if any file is not found
if [ "$not_found_flag" = true ]; then
    exit 2
fi
