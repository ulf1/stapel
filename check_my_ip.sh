#!/bin/bash

#
# PURPOSE
# - use different websites to check my IP address
#
# USAGE
#
#   bash check_my_ip.sh
#
# ANOTHER ONE-LINER
#
#   curl -s http://whatismijnip.nl | cut -d " " -f 5
#
# LINKS
# - http://www.yourownlinux.com/2014/01/how-to-determine-your-public-ip-address-from-linux-terminal.html
# - https://unix.stackexchange.com/questions/22615/how-can-i-get-my-external-ip-address-in-a-shell-script
#


sites=(
    ident.me
    ifconfig.me
    icanhazip.com
    ipecho.net/plain
    ip.tyk.nu
    wgetip.com
);

for url in "${sites[@]}"
do
    printf "\n\n${url}\n"
    
    #pingtest
    ping -c 1 ${url} > /dev/null; 
    
    #check my IP
    if [ $? -eq 0 ]; then
        curl -s "${url}"
    else
        printf "ip checker site is offline"
    fi
done
