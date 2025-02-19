#!/bin/bash

CLI_PATH="$(dirname "$(dirname "$0")")"
HDEV_PATH=$(dirname "$CLI_PATH")
bold=$(tput bold)
normal=$(tput sgr0)

#usage:       $CLI_PATH/hdev new opennic --commit $commit_name_shell $commit_name_driver --project   $new_name --push $push_option
#example: /opt/hdev/cli/hdev new opennic --commit             807775             1cf2578 --project hello_world --push            0

#early exit
is_composer_developer=$($CLI_PATH/common/is_composer_developer)
if [ "$is_composer_developer" = "0" ]; then
    exit 1
fi

echo "Aci estic"
exit

matlab -r "$HDEV_PATH/composer/open_model('/home/jmoyapaya/my_design.slx', '2024.1', '22')"


#author: https://github.com/jmoya82