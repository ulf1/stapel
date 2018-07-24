#!/bin/bash

#
# PURPOSE
#   sync some repos automagically
#
# USE CASE
#   - selected folders/repo are for personal notes, docs, etc
#   - git as fake sync service for these repos
# 
# EXAMPLE
#   Copy this file into the common parent directory 
#   of repos you would like to sync automagically
#

#Set the path manually
# cd ~/folder/where/my/repos/are/

#Specify repo folder, i.e. the folder names
#You can also add absolute path to the array
reponames=(
    repo1
    repo2
    anotherrepo
    lastexamplerepo
);

#loop over selected subfolders
for folder in "${reponames[@]}"
do
    cd $folder
    git pull origin master
    git add --all && git commit -m "auto synced at $(date)" && git push origin master
    cd ..
done
