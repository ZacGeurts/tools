#/bin/bash

for filename in *.gdi; do
	chdman createcd -i "$filename" -o "${filename%.*}".chd
done