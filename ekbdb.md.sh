#!/bin/bash

# Check if a folder path was provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 folder_path"
  exit 1
fi

# Define a function to recursively rename files with the .ekbdb extension
rename_files() {
  cd "$1"
  for file in *; do
    if [ -d "$file" ]; then
      rename_files "$file"
    elif [ -f "$file" ] && [[ "$file" == *.ekbdb ]]; then
      # Rename the file with mv
      mv "$file" "${file}.md"

      # Rename the file with git mv
      git mv "$file" "${file}.md"
    fi
  done
  cd ..
}

# Call the function to recursively rename files with the .ekbdb extension
rename_files "$1"
