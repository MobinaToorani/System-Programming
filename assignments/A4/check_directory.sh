#!/bin/bash

usage() {
    echo "Usage: $0 <directory> [extension]"
    exit 1
}

verify_directory() {
    if [ ! -d "$1" ]; then
        echo "Error: Directory '$1' not found."
        exit 2
    fi
}

count_files() {
    local dir=$1
    local ext=$2
    local count

    if [[ -z "$ext" ]]; then
        count=$(find "$dir" -type f | wc -l)
    else
        count=$(find "$dir" -type f -name "*.$ext" | wc -l)
    fi
    echo "Number of regular files in directory '$dir': $count"
}

main() {
    if [ "$#" -lt 1 ]; then
        usage
    fi

    local directory="$1"
    local extension="$2"

    verify_directory "$directory"
    count_files "$directory" "$extension"
}

main "$@"
