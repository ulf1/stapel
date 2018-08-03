#!/bin/bash

#
# EXAMPLES
# bash convert_to_utf8.sh -f ~/tmp/weirdchars/ffn.tex
# bash convert_to_utf8.sh -d ~/tmp/weirdchars -m tex
# bash convert_to_utf8.sh -d ~/tmp/weirdchars 
# bash convert_to_utf8.sh -d ~/tmp/weirdchars -s test

#read input arguments
suffix=""
while getopts 'd:m:f:s:' flag; do
    case "${flag}" in
        d) directory="${OPTARG}";;  #The whole folder
        m) mimetype="${OPTARG}";;  #the MIME type without
        f) specfile="${OPTARG}";;   #A specific file
        s) suffix="-${OPTARG}";;   #Suffix
    esac
done


#Filter files
if [ -z ${specfile+x} ]; then
    #not set. thus check the folders
    if [ -z ${mimetype+x} ]; then
        #any files
        files=$(find ${directory} -type f)
    else
        #specfic mime type
        files=$(find ${directory} -type f -name "*.${mimetype}")
    fi
else
    #echo "is set"
    files=("${specfile}")
fi


#Process each file
for fil in "${files[@]}"; do
    echo "Filename: ${fil}"
    enc=$(file -b --mime-encoding "${fil}" | sed -e 's/.*[ ]charset=//')
    echo "Detected Encoding: ${enc}"
    iconv -f ${enc} -t UTF-8 "${fil}" > "${fil}-tmp"
    if [ -z ${suffix+x} ]; then
        mv "${fil}-tmp" ${fil}
    else
        mv "${fil}-tmp" "${fil}${suffix}"
    fi
done
