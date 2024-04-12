#!/bin/bash

# Check if an argument was provided
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <new_notebook_name.ipynb>"
	exit 1
fi

# Define the template and new notebook names
TEMPLATE="template.ipynb"
NEW_NOTEBOOK="$1"

# Check if the template file exists
if [ ! -f "$TEMPLATE" ]; then
	echo "Error: Template file $TEMPLATE not found!"
	exit 2
fi

# Copy the template to the new notebook
cp "$TEMPLATE" "$NEW_NOTEBOOK"
echo "New notebook created: $NEW_NOTEBOOK"
