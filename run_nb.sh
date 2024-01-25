#!/bin/bash

# Stop execution if any command fails except for the notebook execution
set -e

# Get the current Git branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Use awk to extract the part after the slash and convert it to lowercase
WATCH_DIR_PREFIX=$(echo $BRANCH_NAME | awk -F'/' '{print tolower($2)}')

# Find a directory that starts with the extracted prefix (case-insensitive)
# Assuming you are in the root of the git repository
WATCH_DIR=$(find . -type d -name "$WATCH_DIR_PREFIX*" ! -path "./.*" | head -n 1 | sed 's|^\./||')

# Exit if no matching directory is found
if [ -z "$WATCH_DIR" ]; then
	echo "No directory found starting with $WATCH_DIR_PREFIX"
	exit 1
fi

# File to run if changes are detected
NOTEBOOK="Homework_Problems.ipynb"

# Execute the Jupyter notebook
if ! jupyter nbconvert --to notebook --execute "$WATCH_DIR/$NOTEBOOK" --output "$WATCH_DIR/$NOTEBOOK"; then
	echo "Execution failed in $NOTEBOOK"
	exit 1
fi

echo "Executed $NOTEBOOK Successfully"
