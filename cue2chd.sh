#/bin/bash

for filename in *.cue; do
	chdman createcd -i "$filename" -o "${filename%.*}".chd
done