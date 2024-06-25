#!/usr/bin/env bash
#!/bin/bash

# Directory containing the test files
TEST_DATA_DIR="test-data"

# Loop through each test-xxx.in file in the test-data directory
for TEST_FILE in "$TEST_DATA_DIR"/test-*.in; do
	# Read the line from the file
	LINE=$(cat "$TEST_FILE")

	# Extract the arguments
	ARGS=($LINE)

	# Check if the format is correct
	if [ "${ARGS[0]}" != "./translate" ] || [ "${#ARGS[@]}" -ne 4 ]; then
		echo "Invalid format in file $TEST_FILE"
		continue
	fi

	POINTS_FILE="${ARGS[1]}"
	MATRIX_FILE="${ARGS[2]}"
	ITERATIONS="${ARGS[3]}"

	# Check if the points and matrix files exist
	if [ ! -f "$POINTS_FILE" ] || [ ! -f "$MATRIX_FILE" ]; then
		echo "File missing for test: $TEST_FILE"
		echo "Missing: $POINTS_FILE or $MATRIX_FILE"
		continue
	fi

	# Call the translate executable with the extracted arguments
	OUTPUT=$(./translate "$POINTS_FILE" "$MATRIX_FILE" "$ITERATIONS")

	# Print the output of the translate executable
	echo "Output for $TEST_FILE:"
	echo "$OUTPUT"
done
