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
#   bash domainsearch.sh keywords.txt
#   bash domainsearch.sh keywords.txt result.log
# 
#


# newline als seperator
IFS=$'\n'

# disable globbing
set -f

#Set the Keyword list file
if [ $1 ]; then
    keywordfile=${1}
else
    keywordfile="domainsearch-keywords.txt"
fi

#Set log file path
if [ $2 ]; then
    logfile=${2}
else
    logfile="domainsearch-results.log"
fi
#reset logs
rm ${logfile}
touch ${logfile}

#TLDS festlegen
#tldlist=("de" "com" "org" "net" "eu" "co.uk" "uk" "at" "ch" "nl" "be" "lu" "it" "dk" "se" "no" "fi")
tldlist=("com" "org" "net" "eu" "co.uk")

# jede Zeile durchgehen
for word in $(cat "${keywordfile}"); do
  
    #konvertiere zu lower
    word=$(echo ${word} | tr '[:upper:]' '[:lower:]');

    if [ "${word}" != "" ]; then
    
        # alpha-numerisch, mit Umlaute, mit Bindestrich (ohne Whitespace/Sonstige)
        adjname1=$(echo ${word} | tr -cd '[[:alnum:]äöü\-]');
        if [ "${adjname1}" != "" ]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname1}.${tld}"
                nslookup "${adjname1}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                        | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi 

        # alpha-numerisch, mit Umlaute, ohne Bindestrich (ohne Whitespace/Sonstige)
        adjname2=$(echo ${word} | tr -cd '[[:alnum:]äöü]');
        if [[ "${adjname2}" != "" && "${adjname2}" != "${adjname1}" ]]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname2}.${tld}"
                nslookup "${adjname2}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                         | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi

        # alpha-numerisch, Diphtonge, mit Bindestrich (ohne Whitespace/Sonstige)
        adjname3=$(echo ${adjname1} | sed 's/ä/ae/' | sed 's/ö/oe/' | sed 's/ü/ue/');    
        if [[ "${adjname3}" != "" && "${adjname3}" != "${adjname1}" && "${adjname3}" != "${adjname2}" ]]; then
            for tld in "${tldlist[@]}"; do 
                echo "${adjname3}.${tld}"
                nslookup "${adjname3}.${tld}" | tail -3 | head -2 | awk '{ printf "%s ", $0 }' \
                         | awk '{printf "%15s\t%s\n", $4, $2}' >> ${logfile}
            done
        fi

        # alpha-numerisch, Diphtonge, ohne Bindestrich (ohne Whitespace/Sonstige)
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

