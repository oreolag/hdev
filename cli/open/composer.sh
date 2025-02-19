#!/bin/bash

CLI_PATH="$(dirname "$(dirname "$0")")"
HDEV_PATH=$(dirname "$CLI_PATH")
bold=$(tput bold)
normal=$(tput sgr0)

#usage:       $CLI_PATH/hdev open composer --tag $tag_name --project $project_name --version $vivado_version --major $major_version
#example: /opt/hdev/cli/hdev open composer --tag    2025.1 --project   hello_world --version          2024.1 --major             22

#inputs
tag_name=$2
project_name=$4
vivado_version=$6
major_version=$8

#early exit
is_composer_developer=$($CLI_PATH/common/is_composer_developer)
if [ "$is_composer_developer" = "0" ]; then
    exit 1
fi

#constants
COMPOSER_PATH="$HDEV_PATH/composer"
MY_PROJECTS_PATH=$($CLI_PATH/common/get_constant $CLI_PATH MY_PROJECTS_PATH)
WORKFLOW="composer"

#define directories (1)
DIR="$MY_PROJECTS_PATH/$WORKFLOW/$tag_name/$project_name"

#get model name
model_name=$(cat "$DIR/MODEL_NAME")

#change directory (where open_model.p is)
cd $COMPOSER_PATH/common

#open model
matlab -r "open_model('$DIR/$model_name.slx', '$vivado_version', '$major_version')"

#author: https://github.com/jmoya82 - Oreol