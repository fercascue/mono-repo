#!/bin/bash

readarray -t my_array < <(git diff --dirstat=files,0 HEAD~1 | sed -E 's/^[ 0-9.]+% //g' | sed -E 's/\/.*$//g' | tr ' ' '\n' | sort -u)
file_changes=()

# Start the JSON
file_changes+=("[")

# loop through the images, and output the JSON
# keep track of the index of output items
counter=1
len=${#my_array[@]}

#for source in "${my_array[@]}"
for (( i=1; i<$len; i++ ));
do
 #  if [[ "$source" != *"github"* ]]; then
        file_changes+=(\"${my_array[$i]}\")
        (( counter = counter + 1 ))
        # Add a comma unless it is the last element in the array
        if [ $counter -lt ${len} ]
        then
            file_changes+=(",")
        else
            file_changes+=("")
        fi
        
  # fi
done

# Close the JSON
file_changes+=("]")
echo -e "${file_changes[*]}" | tr -d '[:space:]'