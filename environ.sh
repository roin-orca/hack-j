#!/bin/bash

# Find the PID of node process (gets the newest one if multiple exist)
NODE_PID=$(pgrep -n node)

if [ -z "$NODE_PID" ]; then
    echo "Error: No node process found"
    exit 1
fi

echo "Found node process with PID: $NODE_PID"

# Read and export environment variables from /proc/<pid>/environ
# The environ file contains null-terminated strings
while IFS= read -r -d '' env_var; do
    if [[ "$env_var" == *"="* ]]; then
        export "$env_var"
        echo "Exported: ${env_var%%=*}"
    fi
done < "/proc/$NODE_PID/environ"

echo "Environment variables exported successfully"
