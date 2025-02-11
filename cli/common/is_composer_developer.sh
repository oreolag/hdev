#!/bin/bash

user_name=$1
organization_name=$2

if [ "$#" -ne 2 ] ; then
    echo ""
    echo "$0: exactly 2 arguments expected. Example: ./group_member_check jmoyapaya vivado_developers"
    exit
fi

#check if group exists
if [ $(getent group $organization_name) ]; then
  #the group exists
  echo "" >&/dev/null
else
  echo ""
  echo "The group $organization_name does not exist."
  echo ""
  exit
fi

if getent group $organization_name | grep -q "\b${user_name}\b"; then
    echo "1"
else
    echo "0"
fi