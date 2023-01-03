#!/bin/bash

readarray -t my_array < <(git diff --dirstat=files,0 HEAD~1 | sed -E 's/^[ 0-9.]+% //g' | sed -E 's/\/.*$//g')
file_changes=()
# Start the JSON
file_changes+=("[")

# loop through the images, and output the JSON
# keep track of the index of output items
counter=1
for source in "${my_array[@]}"
do
    file_changes+=(\"$source\")
    # Add a comma unless it is the last element in the array
    if [ $counter -lt ${#my_array[@]} ]
    then
        file_changes+=(",")
    else
        file_changes+=("")
    fi
    (( counter = counter + 1 ))
done

# Close the JSON
file_changes+=("]")
echo -e "${file_changes[*]}" | tr -d '[:space:]'