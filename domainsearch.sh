#!/bin/bash

# PURPOSE
# - The script combines a keyword list with given top-level domains
#   and runs `nslookup`
# - The log file stores the server's IP address of each domain. 
#   In some cases the IP of the whois server will show. This 
#   can indicate the domain might be available (it does not mean
#   that the domina is availble). In such cases run
#
#       whois domainame.tld
#
# USAGE
#
#   bash domainsearch.sh
#   bash domainsearch.sh -l result.log
#   bash domainsearch.sh -k keywords.txt
#   bash domainsearch.sh -t tldlist.txt
#   bash domainsearch.sh -l result.log -l keywords.txt -t tldlist.txt
# 
#   bash domainsearch.sh -l ~/tmp/dresult.log -k ~/tmp/dwords.txt -t ~/tmp/dtldlist.txt
#
# EXAMPLE
# 
#   bash domainsearch.sh
#   bash domainsearch.sh -l domainsearch-result.log
#   bash domainsearch.sh -k domainsearch-keywords.txt
#   bash domainsearch.sh -t domainsearch-tldlist.txt
#   bash domainsearch.sh -l domainsearch-result.log -k domainsearch-keywords.txt -t domainsearch-tldlist.txt
#


# newline als seperator
IFS=$'\n'

# disable globbing
set -f

#set default settins
logfile="domainsearch-results.log"
keywords=("example", "this-is-an-example")
tldlist=("com" "org" "net" "eu")
#tldlist=("de" "com" "org" "net" "eu" "co.uk" "uk" "at" "ch" "nl" "be" "lu" "it" "dk" "se" "no" "fi")

#read input arguments
while getopts 'l:k:t:' flag; do
    case "${flag}" in
        l) logfile="${OPTARG}";;   #Set log file path
        k) read -d '' -r -a keywords < "${OPTARG}";;  #array from keyword list file
        t) read -d '' -r -a tldlist < "${OPTARG}";;   #array from TLD list file
    esac
done


#reset logs
rm ${logfile}
touch ${logfile}


# loop over each keyword
for word in "${keywords[@]}"; do
  
    #convert word to lower case
    word=$(echo ${word} | tr '[:upper:]' '[:lower:]');

    if [ "${word}" != "" ]; then
    
        #alpha-numeric, with German Umlaute, with Dash (without whitespaces, etc)
        adjname1=$(echo ${word} | tr -cd '[[:alnum:]äöü\-]');
        if [ "${adjname1}" != "" ]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname1}.${tld}"
                nslookup "${adjname1}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                        | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi 

        #alpha-numeric, with German Umlaute (without dash, whitespaces, etc)
        adjname2=$(echo ${word} | tr -cd '[[:alnum:]äöü]');
        if [[ "${adjname2}" != "" && "${adjname2}" != "${adjname1}" ]]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname2}.${tld}"
                nslookup "${adjname2}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                         | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi

        #alpha-numeric, with diphtonge instead of German Umlaute, with dash (without whitespaces, etc)
        adjname3=$(echo ${adjname1} | sed 's/ä/ae/' | sed 's/ö/oe/' | sed 's/ü/ue/');    
        if [[ "${adjname3}" != "" && "${adjname3}" != "${adjname1}" && "${adjname3}" != "${adjname2}" ]]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname3}.${tld}"
                nslookup "${adjname3}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                         | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi

        #alpha-numeric, with diphtonge instead of German Umlaute (without dash, whitespaces, etc)
        adjname4=$(echo ${adjname2} | sed 's/ä/ae/' | sed 's/ö/oe/' | sed 's/ü/ue/');    
        if [[ "${adjname4}" != "" && "${adjname4}" != "${adjname1}" && "${adjname4}" != "${adjname2}" && "${adjname4}" != "${adjname3}" ]]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname4}.${tld}"
                nslookup "${adjname4}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                         | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi
    
    fi

done

