#!/bin/bash

# HOW TO USE
#   bash rand2file.sh -n 13 -l 30 -u 40 -b test -d ~/tmp
#   bash rand2file.sh -n 300 -l 1 -u 50
#   bash rand2file.sh -n 300 -l 0 -u 36

#default arguments
base="output"
lo=0
up=4294967295 #2^32-1

# read cli input arguments
while getopts n:l:u:b:d: option
do
    case "${option}" 
    in
        n) num=${OPTARG};;
        l) lo=${OPTARG};;
        u) up=${OPTARG};;
        b) base=${OPTARG};;
        d) dir="${OPTARG}/"; mkdir ${dir};
        esac
done

#target file
targetfile="${dir}${base}.csv"

rm ${targetfile}
touch ${targetfile}

#range of integer numbers
wd=$((${up} - ${lo} + 1));

#loop over $num
for ((i=0; i<${num}; i++)); 
do 
    #generate a PRN
    r=$(od -An -N4 -t uL /dev/urandom);
    #scale to [lo,up] interval and pipe into output file
    printf "%d\n" $((r % ${wd} + ${lo})) >> ${targetfile};
done 
