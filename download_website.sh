#!/bin/bash

# USAGE
#       bash download_website.sh http://example.com/subfolder
#       bash download_website.sh http://example.com/subfolder ~/tmp/dumphere
#
# LINKS
#       https://www.linuxjournal.com/content/downloading-entire-web-site-wget

#check if url has been provided
if [ -z ${1+x} ]; then
    exit;
fi

#strip the domain name
d=$(echo $1 | awk -F[/:] '{print $4}')

#enter the download folder
if [ ! -z ${2+x} ]; then
    mkdir -p "${2}"
    cd "${2}"
fi

#download
wget --recursive \
    --no-clobber \
    --page-requisites \
    --html-extension \
    --convert-links \
    --restrict-file-names=windows \
    --domains ${d} \
    --no-parent \
    $1