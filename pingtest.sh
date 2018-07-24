#!/bin/bash

#
# WHAT IS THIS?
# - script with an empty if-else block depending on 
#   being connected to the internet or not
# - Copy this script and adjust to your needs (e.g.
#   what commands when online or offline)
#
# JUST THE PINGTEST PLEASE
#
#   ping -c 1 8.8.8.8 > /dev/null && echo "up $?" || echo "down $?"
#
# NOTES
# - ping returns 0 (up) or 1 (down). 
# - you can use it to check if your computer is connected 
#   to a certain DNS server, gateway, or any other computer. 
# - you can trigger different actions if the computer 
#    is connected or not.
# 
# EXAMPLE
#   The ping address is 8.8.8.8 by default (Google's DNS server)
#
#       bash pingtest.sh
#
#   You can try to ping your router at home, e.g. a common 
#   local network router address might be
#
#       bash pingtest.sh 192.168.1.1
#
#   You can also check if a certain server is up and running, 
#   e.g. at 192.168.1.123
#
#       bash pingtest.sh 192.168.1.123
#

#set ping address
if [ $1 ]; then
    ipaddr=$1
else
    ipaddr=8.8.8.8
fi

#run ping
echo "Trying to ping ${ipaddr}"
ping -c 1 $ipaddr > /dev/null; 

#do stuff 
if [ $? -eq 0 ]; then
    echo "ONLINE"
    echo " ping result: $?"
    echo " do stuff you do when connected"
else
    echo "OFFLINE"
    echo " ping result: $?"
    echo " do stuff you do when connection failed"
fi
