#!/bin/bash

#user_name=$1
#team_name=$2

#constants
organization_name="oreolag"

#if [ "$#" -ne 2 ] ; then
#    echo ""
#    echo "$0: exactly 2 arguments expected. Example: ./is_composer_developer jmoya82 ETHZ"
#    exit
#fi

#gh_check
logged_in=$($CLI_PATH/common/gh_auth_status)
if [ "$logged_in" = "0" ]; then 
  exit 1
fi

#get gh user
user_name=$(gh api user --jq '.login')

#check on team first
#team_exists=$(gh api "/orgs/$organization_name/teams" --paginate | jq -r '.[].slug' | grep -i -w "$team_name")
#if [ -z "$team_exists" ]; then
#    echo "0"
#    exit 1
#fi

#check on user
#is_member=$(gh api "/orgs/$organization_name/teams/$team_name/members" --paginate | jq -r '.[].login' | grep -w "$user_name")
state=$(gh api "/orgs/$organization_name/memberships/$user_name" 2>/dev/null | jq -r '.state' | grep -w "active")
if [ "$state" = "active" ]; then
    echo "1"
else
    echo "0"
fi