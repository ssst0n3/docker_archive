#!/bin/bash

# Get the absolute path of the script directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the parent directory of the script directory
parent_dir="$(dirname "$script_dir")"

# Iterate through each first-level subdirectory in the parent directory
for project in "$parent_dir"/*/; do
  # Check if the file is indeed a directory
  if [ -d "$project" ]; then
    # Recursively find all '.env' files in the project directory and count them as artifacts
    artifact_count=$(find "$project" -type f -name ".env" 2>/dev/null | wc -l)
    
    # Consider the directory a valid project only if it contains at least one '.env' file
    if [ "$artifact_count" -gt 0 ]; then
      # Extract the project name (the last part of the directory path)
      project_name=$(basename "$project")
      echo "$project_name: $artifact_count"
    fi
  fi
done