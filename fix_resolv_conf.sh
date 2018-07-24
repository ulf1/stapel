#!/bin/bash

# PURPOSE
# - Fix DNS resolve after crash
# 
# NOTES
# - Happened on my Ubuntu laptop very often because 
#   i often switch between wifi networks, local eth,
#   and differen VPN connections. 
#
# LINKS
#   http://askubuntu.com/a/54889

#get root access
su
#delete config file
rm /etc/resolv.conf
#well the config file is just a symbolic link
ln -s ../run/resolvconf/resolv.conf /etc/resolv.conf
#update
resolvconf -u

