#!/bin/bash

show_usage() {
    echo "Usage: $0 <filename>"
    exit 1
}

check_file_exists() {
    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found."
        exit 2
    fi
}

read_file_to_array() {
    local filename=$1
    local -n wordsRef=$2
    local currentWord=""
    local char

    while IFS= read -r -n1 char; do
        if [[ "$char" =~ [A-Za-z0-9] ]]; then
            currentWord+="$char"
        elif [[ -n "$currentWord" ]]; then
            wordsRef+=("$currentWord")
            currentWord=""
        fi
    done < "$filename"

    if [[ -n "$currentWord" ]]; then
        wordsRef+=("$currentWord")
    fi
}

print_array() {
    local -n arrRef=$1
    echo "Array elements:"
    for word in "${arrRef[@]}"; do
        echo "$word"
    done
}

main() {
    if [ "$#" -ne 1 ]; then
        show_usage
    fi

    local filename="$1"
    check_file_exists "$filename"

    declare -a wordsArray
    read_file_to_array "$filename" wordsArray
    print_array wordsArray
}

main "$@"
