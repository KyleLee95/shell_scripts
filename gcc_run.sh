#!/bin/bash

# Check if a file name is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <source_file.c>"
	exit 1
fi

# Get the base name of the file without the .c extension
base_name=$(basename "$1" .c)

# Compile the program
gcc -std=gnu11 "$1" -o "${base_name}.out"

# Check if the compilation was successful
if [ $? -eq 0 ]; then
	# Run the program if compilation was successful
	./"${base_name}.out"
else
	echo "Compilation failed."
fi
