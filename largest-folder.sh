#!/bin/bash

#
# USAGE
# 
#       bash largest-folder.sh
# 
#   Search the biggest folders in "/this/folder"
#       bash largest-folder.sh /this/folder
#
#   Display the 7 biggest subfolders:
#       bash largest-folder.sh /this/folder 7
# 
#   Display the 7 biggest subfolders or subsubfolders 
#       bash largest-folder.sh /this/folder 7 2
#
#   Search Largest folder of the user directory
#       bash largest-folder.sh ~ 20 8
#

#Which folder?
if [ $1 ]; then
    path=$1
else
    path=$(pwd); 
fi

#How many results?
if [ $2 ]; then
    num=$2
else
    num=10; 
fi

#Levels of subfolders?
if [ $3 ]; then
    depth=$3
else
    depth=1
fi

#run the command
du -hd "${depth}" "${path}" | sort -n -r | head -n "${num}"
