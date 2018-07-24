#!/bin/bash

#
# USAGE
#   bash start-simplehttp.sh
#
# NOTES
# - copy this script to the parent directory of your website,
#   i.e. where the "index.html" is located
#

#
# SETTINGS
#

#Set the port of the web server
port=58086

#Set the web browser CLI command
program=open
#program=chromium-browser

#Set startpage
startpage=start-simplehttp.html


#
# THE SCRIPT
#

#close all previous instances of SimpleHTTPServer
#pkill -f "python -m SimpleHTTPServer"
kill $(ps aux | awk '/ython -m SimpleHTTPServer/ { print $2}')

#Start python's SimpleHTTPServer
nohup python -m SimpleHTTPServer ${port} &

#Open the Browser
nohup "${program}"  "http://localhost:${port}/${startpage}" &

#show the log in the terminal
tail -f nohup.out
