#!/bin/bash

#
# PURPOSE
#   push all changes of all git repos
#
# USE CASE
#   - just sync all repos with personal notes, docs, etc.
#   - use git repos as kind of fake sync service
# 
# EXAMPLE
#   Copy this file into the common parent directory 
#   of all repos you would like to sync automagically
#


#Set the path manually
# cd ~/folder/where/my/repos/are/


#loop over all subfolders
for f in */
do
    #open repo
    echo $f
    cd $f
    #download latest
    git pull origin master
    #upload local changes
    git add --all
    git commit -m "auto synced at $(date)"
    git push origin master
    #next
    cd ..
done
