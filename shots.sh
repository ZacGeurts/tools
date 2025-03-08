#!/bin/bash

# By Zachary Geurts
# This software is for me alone.
# This overwrites thumbnails without asking.
# This software is not free. It is not for distribution.
# It is not to be looked at, not to be run, opened, executed, operated.
# It is not to be deleted, moved, copied, or edited.
# Do not touch it, taste it, sniff it, listen to it, or brain scan it.
# Nothing is implied with this software.
# There is no warranty, no guarantee, and no responsibility of functionality.
# Damages caused from or by this software, including but not limited to,
# penis enlargement, impregnating your wife, your wife growing chest hair,
# poisoning your pet or burning your house down is the sole
# responsibility of improper usage by violating the above.
# All usage is to be considered improper.
# Requires inotify-tools sed imagemagik exiftool retroarch killall osd_cat

# Stop program is ctrl-c
# Update system_dir then save and restart shots.sh
# Use Retroarch 1.19+ for thumbnail format
# This is only configured for this computer, Windows? No chance.

# Turn off GPU screenshot in Retroarch video settings
# If using GPU screenshot you will want windowed mode to use actual pixels. (itty bitty)
# AND GPU SS will capture notifications and pause icons etc.

# CONFIGURE once then just update as needed the following line
system_dir='Acorn - BBC Micro'
# See shortcuts below for correct folder names

# ---- CONFIGURE these once if needed --------
src_dir='/home/'"$USER"'/.config/retroarch/screenshots'			# Default
dest_dir='/home/'"$USER"'/.config/retroarch/thumbnails/'"${system_dir}"	# Default

do_backup=1																# 0 = do not create backup duplicate
backup_dir='/mnt/9dfc4c69-a0b6-4668-b905-131459450269/WIP'		# My SSD
# Existing thumbnails do not back up. They are overwritten.
# Backup puts a copy of NEW thumbnails so you can upload them later
# So you do not lose them in the thumbnails pile
# this can be disabled if you do not intend to upload later
# or have no interest is seperating your shots from existing thumbnails

use_metadata=1
# adds 1MB every 50,000 images at 20 characters/bytes
meta_comment="By Zachary Geurts"
meta_location='https://github.com/ZacGeurts'
# --------------------------------------------

# Shortcut list to copy to system_dir
#'Acorn - BBC Micro'
#'Amstrad - CPC'
#'Amstrad - GX4000'
#'Arduboy Inc - Arduboy'
#'Atari - 2600'
#'Atari - 5200'
#'Atari - 7800'
#'Atari - 8-bit'
#'Atari - Jaguar'
#'Atari - Lynx'
#'Atari - ST'
#'Atomiswave'
#'Bandai - WonderSwan'
#'Bandai - WonderSwan Color'
#'Cannonball'
#'Casio - PV-1000'
#'Cave Story'
#'ChaiLove'
#'CHIP-8'
#'Coleco - ColecoVision'
#'Commodore - 64'
#'Commodore - Amiga'
#'Commodore - CD32'
#'Commodore - CDTV'
#'Commodore - PET'
#'Commodore - Plus-4'
#'Commodore - VIC-20'
#'Dinothawr'
#'DOOM'
#'DOS'
#'Elektronika - BK-0010/BK-0011(M)'
#'Elektronika - BK-001-411'
#'Elektronika - BK-0010-0011M'
#'Emerson - Arcadia 2001'
#'Enterprise - 128'
#'Fairchild - Channel F'
#'FBNeo - Arcade Games'
#'Flashback'
#'GamePark - GP32'
#'GCE - Vectrex'
#'Handheld Electronic Game'
#"Jump 'n Bump" needs quotes instead due to apostrophe
#'LowRes NX'
#'Lutro'
#'Magnavox - Odyssey2'
#'MAME' Covers 2003 2010 etc
#'Mattel - Intellivision'
#'Microsoft - MSX'
#'Microsoft - MSX2'
#'MicroW8'
#'NEC - PC-8001 - PC-8801'
#'NEC - PC-98'
#'NEC - PC Engine CD - TurboGrafx-CD'
#'NEC - PC Engine SuperGrafx'
#'NEC - PC Engine - TurboGrafx 16'
#'NEC - PC-FX'
#'Nintendo - Family Computer Disk System'
#'Nintendo - Game Boy'
#'Nintendo - Game Boy Advance'
#'Nintendo - Game Boy Color'
#'Nintendo - Nintendo 64'
#'Nintendo - Nintendo 64DD'
#'Nintendo - Nintendo Entertainment System'
#'Nintendo - Pokemon Mini'
#'Nintendo - Sufami Turbo'
#'Nintendo - Super Nintendo Entertainment System'
#'Nintendo - Virtual Boy'
#'Philips - CD-i'
#'Philips - Videopac+'
#'Quake'
#'Quake II'
#'Rick Dangerous'
#'ScummVM'
#'Sega - 32X'
#'Sega - Dreamcast'
#'Sega - Game Gear'
#'Sega - Master System - Mark III'
#'Sega - Mega-CD - Sega CD'
#'Sega - Mega Drive - Genesis'
#'Sega - PICO'
#'Sega - Saturn'
#'Sega - SG-1000'
#'Sega - ST-V'
#'Sharp - X1'
#'Sharp - X68000'
#'Sinclair - ZX 81'
#'Sinclair - ZX Spectrum +3'
#'SNK - Neo Geo'
#'SNK - Neo Geo CD'
#'SNK - Neo Geo Pocket'
#'SNK - Neo Geo Pocket Color'
#'Sony - PlayStation'
#'Sony - PlayStation 2'
#'Sony - PlayStation Portable (PSN)'
#'Spectravideo - SVI-318 - SVI'
#'The 3DO Company - 3DO'
#'Thomson - MOTO'
#'TIC-80'
#'Tiger - Game.com'
#'Tomb Raider'
#'Uzebox'
#'Vircon32'
#'VTech - CreatiVision'
#'VTech - V.Smile'
#'WASM-4'
#'Watara - Supervision'
#'Welback - Mega Duck'
#'Wolfenstein 3D'

# ----------Nothing to mess with below here-------
# unless your screenshot has wrong aspect ratio then check it out.
# might be easier to adjust core or change core than edit this.
# 512 is max dimension to upload per Retroarch policy
# Search for # CORRECT ASPECT RATIO
# ! means force and ignore aspect.
# resize 512 will scale height as well, 512! leaves height alone, etc.
# mogrify is imagemagik, convert works too, but whatever.
# very powerful, check 'man mogrify' or web search some stuff.

echo '---------------------------------------------'
echo Configured currently for
echo $system_dir
echo ' '
echo Screenshots configured for
echo $src_dir
echo ' '
echo Thumbnails configured for
echo $dest_dir
if [ "$do_backup" = "1" ]; then
	echo ' '
	echo Backup configured for
	echo $backup_dir
fi
if [ "$use_metadata" = "1" ]; then
	echo ' '
	echo Metadata configured for
	echo Comment: $meta_comment
	echo Location: $meta_location
fi
echo '---------------------------------------------'
echo If anything is not correct press CTRL-C now and edit shots.sh
echo ' '
echo inotify scans recursive on screenshots folder
echo we want it empty to prevent slowdowns
echo This will delete your screenshots!
read -p "Empty screenshots folder (recommended)? y or n: " yn_var
case $yn_var in
	[yY]* ) 
		rm -rf $src_dir; 
		mkdir $src_dir;
	;;
	[nN]* )
		echo "Leaving screenshots alone."; 
	;;
	* ) echo "Invalid response, Exiting!"; exit;
esac

# cleanup function
# clean up any remaining process when ctrl-c
cleanup() {
	killall -q osd_cat
	killall -q inotifywait
	exit	
}
trap cleanup SIGINT

is_titlepng="Named_Snaps" # flipflop, this flips before doing anything so titles starts
NOT_GPU_SHOT=1 # ignore this, it disables the text and is unneeded

echo ' '
echo shots.sh by Zachary Geurts
echo Creates Retroarch thumbnails from screenshots.
echo Awaits a new image in the screenshots folder 
echo does stuff to move it to thumbnails.
echo ' '
echo Take screenshots with F8 key or menu. Two per program.
echo First is title screen and second is gameplay.
echo Close program and start another program and then press F8 twice...
echo ' '
echo Note
echo Scroll lock key for keyboard focus, undo scroll lock for F8 to work.
echo Disable GPU screenshot in Retroarch settings.
echo You can use P to pause before snapping.
echo ' '

if [ "$NOT_GPU_SHOT" = "1" ]; then
		echo "Title" | osd_cat --pos=top --align=left --colour=yellow --offset=10 --outlinecolour=black --outline=1 --delay=999999 --age=999999 --font=-misc-fixed-bold-r-normal--17-*-*-*-c-*-*-* &
fi
echo "---First image is a Title---"

while true; do
	inotifywait -m -r -e close_write --format %w%f "$src_dir" | while read fname; do
		fname_new=$(echo "$fname"  | sed 's#.*/##' | sed 's/\(.*\)-\(.\+\)/\1/' | sed 's/\(.*\)-\(.\+\)/\1/').png
		# sed shaves -date and -time then do
		# Retroarch character compatability
		fname_new=$(echo $fname_new | tr '<' "_")
		fname_new=$(echo $fname_new | tr '>' "_")
		fname_new=$(echo $fname_new | tr '\\' "_")
		fname_new=$(echo $fname_new | tr '/' "_")
		fname_new=$(echo $fname_new | tr '&' "_")
		fname_new=$(echo $fname_new | tr ':' "_")
		fname_new=$(echo $fname_new | tr '|' "_")
		fname_new=$(echo $fname_new | tr '?' "_")
		fname_new=$(echo $fname_new | tr '*' "_")
		if [ "$is_titlepng" = "Named_Titles" ]; then
			is_titlepng='Named_Snaps'
			echo ${is_titlepng} new image detected.
		else			
			is_titlepng='Named_Titles'
			echo ${is_titlepng} new image detected.
		fi
		mkdir -p "${dest_dir}/${is_titlepng}"
        mv "$fname" "${dest_dir}/${is_titlepng}/${fname_new}"
		# --- # CORRECT ASPECT RATIO ---
		if [ "$system_dir" = "Acorn - BBC Micro" ]; then
			echo "$system_dir" detected. Resizing.
			mogrify -resize 640!x512! -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
			mogrify -resize 384 -depth 4 -type optimize -alpha off -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$system_dir" = "Amstrad - CPC" ] || [ "$system_dir" = "Uzebox" ] || [ "$system_dir" = "Amstrad - GX4000" ]; then
			echo "$system_dir" detected. Resizing 100x200 percent.
			mogrify -resize '100%x200%' -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$system_dir" = "Philips - CD-i" ]; then
			echo "$system_dir" detected. Forcing 512 width.
			mogrify -resize 640!x480! -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
			mogrify -resize 512 -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$system_dir" = "NEC - PC-FX" ] || [ "$system_dir" = "NEC - PC Engine SuperGrafx" ]; then
			echo "$system_dir" Resizing if needed.
			mogrify -resize '256!' -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$system_dir" = "Commodore - CDTV" ]; then
			echo "$system_dir" Resizing to 512.
			mogrify -resize 512!x384! -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$system_dir" = "Nintendo - Nintendo 64" ]; then
			echo "$system_dir" Resizing to 384.
			mogrify -type optimize -alpha off -verbose -quality 95 -resize 384 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$system_dir" = "Sega - Dreamcast" ] || [ "$system_dir" = "Atomiswave" ]; then
			echo "$system_dir" Resizing if needed.
			mogrify -resize 512 -quality 95 "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		# ---- END CORRECT ASPECT
		if [ "$use_metadata"=1 ]; then
			exiftool -overwrite_original -comment="$meta_comment" -location="$meta_location" "${dest_dir}/${is_titlepng}/${fname_new}"
		fi
		mkdir -p "${backup_dir}/thumbnails/${system_dir}/${is_titlepng}"
		if [ "$do_backup" ]; then
			cp -u "${dest_dir}/${is_titlepng}/${fname_new}" "${backup_dir}/thumbnails/${system_dir}/${is_titlepng}/${fname_new}"
		fi
		if [ "$is_titlepng" = "Named_Snaps" ]; then
			if [ $NOT_GPU_SHOT ]; then
				killall -q osd_cat
				echo "Title" | osd_cat --pos=top --align=left --colour=yellow --offset=10 --outlinecolour=black --outline=1 --delay=999999 --age=999999 --font=-misc-fixed-bold-r-normal--17-*-*-*-c-*-*-* &
			fi
			echo "---Next image is a Title---"
		else
			if [ "$NOT_GPU_SHOT" = "1" ]; then
				killall -q osd_cat
				echo "Action" | osd_cat --pos=top --align=left --colour=yellow --offset=10 --outlinecolour=black --outline=1 --delay=999999 --age=999999 --font=-misc-fixed-bold-r-normal--17-*-*-*-c-*-*-* &
			fi
			echo "---Next image is an Action---"
		fi	
	done
done
