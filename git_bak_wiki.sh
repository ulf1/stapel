#!/bin/bash

#Your Github username
#where all repos are stored
username=ulf1

#Specify repo folders
#Pick only repos with Github wiki
#You can also add absolute path to the array
reponames=(
    stapel
);


# create backup directory if not exists
bakdir=~/tmp/bak-wiki

mkdir -p ${bakdir}
cd ${bakdir}

#loop over selected subfolders
for folder in "${reponames[@]}"
do
    #Github Wikis are their own little repos
    reponame="${folder}.wiki"

    #clone wiki repo 
    if [ ! -d ${reponame} ]; then
        git clone "git@github.com:${username}/${reponame}.git" 
    fi

    #enter repo and pull
    cd "${reponame}"
    git pull origin master
    cd ..
done

#leave backup directory
cd ..