#!/bin/bash

# Function to check file validity
check_file() {
    if [ ! -f "$1" ]; then
        echo "Error: File does not exist or is not a normal file."
        exit 2
    elif [ ! -r "$1" ]; then
        echo "Error: File cannot be read."
        exit 3
    fi
}

# Function to sort file contents
funcsort() {
    local mode="$1"
    local file="$2"
    check_file "$file"
    if [ "$mode" = "-n" ]; then
        sort -n "$file"
    else
        sort "$file"
    fi
}

# Main script logic
if [ $# -eq 1 ]; then
    funcsort "" "$1"
elif [ $# -eq 2 ]; then
    if [ "$1" = "-n" ]; then
        funcsort "$1" "$2"
    else
        funcsort "" "$1" > "$2"
    fi
elif [ $# -eq 3 ] && [ "$1" = "-n" ]; then
    funcsort "$1" "$2" > "$3"
else
    echo "Usage: $0 [-n] <filename> [output file]"
    exit 1
fi
