#!/bin/bash

MODELS_PATH=$1

# Declare global variables
declare -g model_found="0"
declare -g model_name=""
declare -g multiple_models="0"

#get models
cd "$MODELS_PATH"
models=( ""* )

# Check if there is only one directory
if [ ${#models[@]} -eq 1 ]; then
    model_found="1"
    model_name=${models[0]}
else
    multiple_models="1"
    PS3=""
    select model_name in "${models[@]}"; do 
        if [[ -z $model_name ]]; then
            echo "" >&/dev/null
        else
            model_found="1"
            break
        fi
    done
fi

# Return values
echo "$model_found"
echo "$model_name"
echo "$multiple_models"