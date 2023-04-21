#!/bin/bash

# Check if a folder path was provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 folder_path"
  exit 1
fi

# Change to the provided folder path
cd "$1"

# Loop through all files and directories recursively
find . -depth -name '*:*' -execdir bash -c '
  for filename; do
    # Replace colons with hyphens in the filename
    newname=$(echo "$filename" | tr ":" "-")

    # Rename the file or directory with mv
    mv "$filename" "$newname"

    # Rename the file or directory with git mv
    git mv "$filename" "$newname"
  done
' bash {} +
