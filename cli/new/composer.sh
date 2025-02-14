#!/bin/bash

CLI_PATH="$(dirname "$(dirname "$0")")"
HDEV_PATH=$(dirname "$CLI_PATH")
bold=$(tput bold)
normal=$(tput sgr0)

#usage:       $CLI_PATH/hdev new composer --tag $tag_name  --project   $new_name --push $push_option
#example: /opt/hdev/cli/hdev new composer --tag    2025.1  --project hello_world --push            0

#early exit
url="${HOSTNAME}"
hostname="${url%%.*}"
is_build=$($CLI_PATH/common/is_build $CLI_PATH $hostname)
is_composer_developer=""
if [ "$is_build" = "0" ] && [ "$is_composer_developer" = "0" ]; then
    exit 1
fi

echo "Aci estic"
exit

matlab -r "$HDEV_PATH/composer/open_model('/home/jmoyapaya/my_design.slx', '2024.1', '22')"


#author: https://github.com/jmoya82