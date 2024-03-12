#!/bin/bash

filename=$1
declare -a words
word=""

# Check if a filename has been provided
if [[ -z "$filename" ]]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Check if the file exists
if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Read the file character by character
while IFS= read -r -n1 char; do
    # Check if the character is a letter or a new line
    if [[ $char =~ [A-Za-z] ]] || [[ $char == "" ]]; then
        word+=$char    # Append character to word
    elif [[ $char == ' ' ]] || [[ $char == '' ]]; then
        if [[ -n $word ]]; then
            words+=($word)  # Add word to array
            word=""         # Reset word
        fi
    fi
done < "$filename"

# Add last word to array if not empty
if [[ -n $word ]]; then
    words+=($word)
fi

# Print array elements
for word in "${words[@]}"; do
    echo "$word"
done

