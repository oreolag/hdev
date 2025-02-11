#!/bin/bash

user_name=$1
team_name=$2

#constants
organization_name="oreolag"

if [ "$#" -ne 2 ] ; then
    echo ""
    echo "$0: exactly 2 arguments expected. Example: ./is_composer_developer jmoya82 ETHZ"
    exit
fi

#gh_check
logged_in=$($CLI_PATH/common/gh_auth_status)
if [ "$logged_in" = "0" ]; then 
  exit 1
fi

#check using GitHub CLI
is_member=$(gh api "/orgs/$organization_name/teams/$team_name/members" --paginate | jq -r '.[].login' | grep -w "$user_name")

#return value
if [ ! $is_member = "" ]; then
    echo "1"
else
    echo "0"
fi