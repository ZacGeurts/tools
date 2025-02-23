#!/bin/sh

# copy this to a roms folder
# moves everything out of higher level folders to the current folder.
# I usually run it a few times if there are folders inside folders.
# delete mover.sh when satisfied.

find . -iname '*.*' -exec mv {} . \;