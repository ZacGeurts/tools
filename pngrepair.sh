#!/bin/sh

echo 'Recursively repairing PNG headers'
echo 'WIP this may not work yet'
echo 'Please be patient...'
find . -iname '*.png' -exec parallel python3 /home/default/Chunklate.py -stfu -a -f ::: {} +
echo 'Done!'