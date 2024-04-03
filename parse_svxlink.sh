#!/bin/bash

input_file="svxlink.conf"
output_file="svxlink.db"

categories=()
current_category=""
current_array=()

while IFS= read -r line; do
    line=$(echo "$line" | tr -d '\r\n') # Remove carriage return and newline characters
    if [[ $line == \[*]* ]]; then
        # New category
        if [ -n "$current_category" ] && [ ${#current_array[@]} -gt 0 ]; then
            categories+=("$current_category")
            printf "%s\n" "${current_array[@]}" >> "$output_file"
        fi
        current_category=${line:1:-1}
        current_array=()
    elif [[ $line == \#* ]]; then
        # Parameter heading
        parameter_heading=$(echo "$line" | cut -d '=' -f 1 | sed 's/# *//')
        parameter=$(echo "$line" | cut -d '=' -f 2-)
        current_array+=("$parameter_heading = $parameter")
    else
        # Regular parameter
        parameter_heading=$(echo "$line" | cut -d '=' -f 1)
        parameter=$(echo "$line" | cut -d '=' -f 2-)
        current_array+=("$parameter_heading = $parameter")
    fi
done < "$input_file"

# Append the last category
if [ -n "$current_category" ] && [ ${#current_array[@]} -gt 0 ]; then
    categories+=("$current_category")
    printf "%s\n" "${current_array[@]}" >> "$output_file"
fi

# Write categories to the output file
for category in "${categories[@]}"; do
    echo "$category" >> "$output_file"
    echo "" >> "$output_file"
done
