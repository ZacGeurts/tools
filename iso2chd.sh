#/bin/bash

for filename in *.iso; do
	chdman createcd -i "$filename" -o "${filename%.*}".chd
done