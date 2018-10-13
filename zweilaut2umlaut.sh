#!/bin/bash

filename=test.txt

perl -p -i -e "s/ae/ä/g;" $filename
perl -p -i -e "s/ue/ü/g;" $filename
perl -p -i -e "s/oe/ö/g;" $filename
perl -p -i -e "s/Ae/Ä/g;" $filename
perl -p -i -e "s/Ue/Ü/g;" $filename
perl -p -i -e "s/Oe/Ö/g;" $filename
