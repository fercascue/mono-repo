#!/bin/bash

readarray -t my_array < <(git diff --dirstat=files,0 HEAD~1 | jq -r '.[].source' )
file_changes=()
# Start the JSON
file_changes+=( {"\"files\":[" )

# loop through the images, and output the JSON
# keep track of the index of output items
counter=1
for source in "${my_array[@]}"
do
    file_changes+=( "{\"source\":\"$source\"}" )
    # Add a comma unless it is the last element in the array
    if [ $counter -lt ${#my_array[@]} ]
    then
        file_changes+=( ",")
    else
        file_changes+=( "")
    fi
    (( counter = counter + 1 ))
done

# Close the JSON
file_changes+=("]}")
echo "${file_changes[*]}"