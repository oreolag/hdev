#!/bin/bash

flags=("$@")  # Assign command-line arguments to the 'flags' array

# Declare global variables
declare -g model_found="0"
declare -g model_name=""

#read flags
for (( i=0; i<${#flags[@]}; i++ ))
do
    if [[ " ${flags[$i]} " =~ " --model " ]] || [[ " ${flags[$i]} " =~ " -m " ]]; then
        model_found="1"
        model_idx=$(($i+1))
        model_name=${flags[$model_idx]}
    fi
done

#return the values
echo "$model_found"
echo "$model_name"