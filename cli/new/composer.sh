#!/bin/bash

CLI_PATH="$(dirname "$(dirname "$0")")"
HDEV_PATH=$(dirname "$CLI_PATH")
bold=$(tput bold)
normal=$(tput sgr0)

#usage:       $CLI_PATH/hdev new composer --tag $tag_name  --project   $new_name --model $model_name --push $push_option
#example: /opt/hdev/cli/hdev new composer --tag    2025.1  --project hello_world --model     opennic --push            0

#early exit
url="${HOSTNAME}"
hostname="${url%%.*}"
is_build=$($CLI_PATH/common/is_build $CLI_PATH $hostname)
is_composer_developer=""
if [ "$is_build" = "0" ] && [ "$is_composer_developer" = "0" ]; then
    exit 1
fi

#inputs
tag_name=$2
new_name=$4
model_name=$6
push_option=$8

#all inputs must be provided
if [ "$tag_name" = "" ] || [ "$new_name" = "" ] || [ "$model_name" = "" ] || [ "$push_option" = "" ]; then
    exit
fi

#constants
MY_PROJECTS_PATH=$($CLI_PATH/common/get_constant $CLI_PATH MY_PROJECTS_PATH)
WORKFLOW="composer"

#define directories
DIR="$MY_PROJECTS_PATH/$WORKFLOW/$tag_name/$new_name"

#create directories
mkdir -p $DIR

#change directory
cd $MY_PROJECTS_PATH/$WORKFLOW/$tag_name

#create repository
if [ "$push_option" = "1" ]; then 
    gh repo create $new_name --public --clone
    echo ""
else
    mkdir -p $DIR
fi

#clone repository
#$CLI_PATH/common/git_clone_hcmp $DIR $tag_name

#save tag_name and model_name
echo "$tag_name" > $DIR/COMPOSER_TAG
echo "$model_name" > $DIR/MODEL_NAME

#add template files
cp $HDEV_PATH/$WORKFLOW/models/$model_name/config_add.sh $DIR/config_add
cp $HDEV_PATH/$WORKFLOW/models/$model_name/config_delete.sh $DIR/config_delete
cp $HDEV_PATH/$WORKFLOW/models/$model_name/config_parameters $DIR/config_parameters
cp -r $HDEV_PATH/$WORKFLOW/models/$model_name/configs $DIR

#copy top slx model
cp $HDEV_PATH/$WORKFLOW/models/$model_name/my_design.slx $DIR/$model_name.slx

#copy all subfolders
cp -r "$HDEV_PATH/$WORKFLOW/models/$model_name/"*/ "$DIR/"

#compile files
chmod +x $DIR/config_add
chmod +x $DIR/config_delete

#push files
if [ "$push_option" = "1" ]; then 
    cd $DIR
    #update README.md 
    if [ -e README.md ]; then
        rm README.md
    fi
    echo "# "$new_name >> README.md
    #add gitignore
    echo ".DS_Store" >> .gitignore
    #add, commit, push
    git add .
    git commit -m "First commit"
    git push --set-upstream origin master
    echo ""
fi

#print message
echo "The project ${bold}$DIR${normal} has been created!"
echo ""

#author: https://github.com/jmoya82 - Oreol 2025