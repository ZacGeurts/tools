#/bin/bash

# I do not think chd has support

for filename in *.img; do
	chdman createcd -i "$filename" -o "${filename%.*}".chd
done