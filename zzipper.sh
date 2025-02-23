#!/bin/sh

# this self deletes so copy it somewhere.
# I use it to zip extracted roms
# zip is far more supported than 7z with cores

for file in *.*; do
	7z a -tzip "${file%.*}".zip "$file"
done

rm zzipper.sh
rm zzipper.zip