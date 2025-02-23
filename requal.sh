#!/bin/bash

# Re-Quality images.
# Retroarch github wants 512 or smaller, these only shrink if over Max
# default currently set to 384 because I wanted more space.
# default color depth is 8 because I wanted more space.
# change to 512 and 16 to be a normal human.
# boxarts you can do something like 1920 to skip resize if not uploading
# logos also 512

# bit chart to colors onscreen at a time
#1 2 VECTREXgray
#2 4 GAMEBOYgray WSUPERVISIONgray
#3 8 CHANNELF
#4 16 INTELLIVISION EPOCHSCV ODDYSSEY MEGADUCKgray
#5 32 MASTERSYSTEM SG-1000 GAMEGEAR LYNX
#6 64 NES GBC
#7 128
#8 256 NEOGEOPC NEOGEOPgray
#9 512 GENESIS TG-16 SNES PICO
#10 1024
#11 2048
#12 4096
#13 8192
#14 16384
#15 32768 32x DS GBA
#16 65536 3DS N64 PS PS2 SATURN DREAMCAST
maxWidth=384
maxHeight=384
default_depth=8 # default color depth for unknown snaps and titles
maxBox=512 # max width and max heightfor boxarts
maxLogo=256 # max width and max height for logos

echo 'Recursively updating PNG quality to 95 (recompress)'
echo 'Setting color depth to 8 bit'
echo 'Turning off alpha channel'
echo "Resizing to $maxWidth width or $maxHeight height if too big"
echo "Boxes use $maxBox for width and height max"
echo "Logos use $maxLogo for width and height max"
echo 'Please be patient...'
echo "Press CTRL-C if this is incorrect!"
read -p "Press Enter to continue." dummy_var

for path in **/*; do

	color_depth="$default_depth" # set to default

	if [[ "$path" == *"Amstrad - CPC/"* ]]; then
		color_depth=6
	fi
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
	if [[ "$path" == *"GCE - Vectrex/"* ]]; then
		color_depth=2
	fi
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
	if [[ "$path" == *"Nintendo - Game Boy/"* ]]; then
		color_depth=2
	fi
	if [[ "$path" == *"Nintendo - Game Boy Advance/"* ]]; then
		color_depth=15
	fi
	if [[ "$path" == *"Nintendo - Game Boy Color/"* ]]; then
		color_depth=2
	fi
#'Nintendo - Nintendo 64'
#'Nintendo - Nintendo 64DD'
	if [[ "$path" == *"Nintendo - Nintendo Entertainment System/"* ]]; then
		color_depth=6
	fi
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
	if [[ "$path" == *"Sega - Saturn/"* ]]; then
		color_depth=16
	fi
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
	echo Color Depth "$color_depth"
	for f in "$path/"*.png;	do
		if [[ "$path" == *"Named_Snaps"* ]]; then
			# if too wide, shrink, else just update
			imageWidth=$(identify -format "%w" "$f")    
			if [ "$imageWidth" -gt "$maxWidth" ]; then
				mogrify -depth "$color_depth" -type optimize -alpha off -verbose -quality 95 -resize "$maxWidth" "$f"
			else
				mogrify -depth "$color_depth" -type optimize -alpha off -verbose -quality 95 "$f"
			fi
			# if too tall or still too tall after width adjust
			imageHeight=$(identify -format "%h" "$f")
			if [ "$imageHeight" -gt "$maxHeight" ]; then
				mogrify -depth "$color_depth" -type optimize -alpha off -verbose -quality 95 -resize x"$maxHeight" "$f"
			fi
		fi
		if [[ "$path" == *"Named_Titles"* ]]; then
			# if too wide, shrink, else just update
			imageWidth=$(identify -format "%w" "$f")    
			if [ "$imageWidth" -gt "$maxWidth" ]; then
				mogrify -depth "$color_depth" -type optimize -alpha off -verbose -quality 95 -resize "$maxWidth" "$f"
			else
				mogrify -depth "$color_depth" -type optimize -alpha off -verbose -quality 95 "$f"
			fi
			# if too tall or still too tall after width adjust
			imageHeight=$(identify -format "%h" "$f")
			if [ "$imageHeight" -gt "$maxHeight" ]; then
				mogrify -depth "$color_depth" -type optimize -alpha off -verbose -quality 95 -resize x"$maxHeight" "$f"
			fi
		fi
		if [[ "$path" == *"Named_Boxarts"* ]]; then
			# if too wide, shrink, else just update
			imageWidth=$(identify -format "%w" "$f")    
			if [ "$imageWidth" -gt "$maxBox" ]; then
				mogrify -depth 16 -type optimize -alpha off -verbose -quality 95 -resize "$maxBox" "$f"
			else
				mogrify -depth 16 -type optimize -alpha off -verbose -quality 95 "$f"
			fi
			# if too tall or still too tall after width adjust
			imageHeight=$(identify -format "%h" "$f")
			if [ "$imageHeight" -gt "$maxBox" ]; then
				mogrify -depth 16 -type optimize -alpha off -verbose -quality 95 -resize x"$maxBox" "$f"
			fi
		fi
		if [[ "$path" == *"Named_Logos"* ]]; then
			# if too wide, shrink, else just update
			imageWidth=$(identify -format "%w" "$f")    
			if [ "$imageWidth" -gt "$maxLogo" ]; then
				mogrify -depth 8 -type TrueColorAlpha -verbose -quality 95 -resize "$maxLogo" "$f"
			else
				mogrify -depth 8 -type TrueColorAlpha -verbose -quality 95 "$path"'/'"$f"
			fi
			# if too tall or still too tall after width adjust
			imageHeight=$(identify -format "%h" "$f")
			if [ "$imageHeight" -gt "$maxLogo" ]; then
				mogrify -depth 8 -type TrueColorAlpha -verbose -quality 95 -resize x"$maxLogo" "$f"
			fi
		fi
		echo "New - $(identify "$f")"
	done
done
echo 'Done!'