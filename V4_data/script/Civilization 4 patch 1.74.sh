#!/bin/bash

if [ "$PLAYONLINUX" = "" ]
then
  exit 0
fi
source "$PLAYONLINUX/lib/sources" 

TITLE="Civilization IV patch 1.74"
AUTHOR="Marco Gerards"
PREFIX="Civilization4"
PREFIXDIR="$REPERTOIRE/wineprefix/$PREFIX"
WORKINGWINEVERSION="1.1.43"

POL_SetupWindow_Init

POL_SetupWindow_checkexist()
{	
	if [ ! -e $REPERTOIRE/wineprefix/$1 ]; then
		if [ "$POL_LANG" == "fr" ]; then
			LNG_PREFIX_NOT_EXIST="Le jeu n'est pas installé."
		else
			LNG_PREFIX_NOT_EXIST="The Game is not installed."
		fi
		POL_SetupWindow_message "$LNG_PREFIX_NOT_EXIST" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}
 
POL_SetupWindow_checkexist "$PREFIX"

POL_SetupWindow_presentation "$TITLE" "Firaxis Games" "http://www.firaxis.com/" "$AUTHOR" "$PREFIX"
select_prefix "$PREFIXDIR"
Use_WineVersion "$WORKINGWINEVERSION"

# Patch the game
POL_SetupWindow_message "The patch v1.74 for $TITLE will be downloaded and installed"

cd "$REPERTOIRE/ressources"
if [ ! -e Civ4Patch1.74_Final.exe ]; then
  POL_SetupWindow_download "Downloading $TITLE" "$TITLE" "http://www.firaxis.com/downloads/Patch/Civ4Patch1.74_Final.exe" 
fi
POL_SetupWindow_wait_next_signal "Patching game..." "$TITLE"
wine Civ4Patch1.74_Final.exe
POL_SetupWindow_detect_exit

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF0ACgkQ5TH6yaoTykcXRACeIdVkRPNwFeiMsRkPm21ZbSlf
lCAAniMqYfVKewLo6yq+/Irdj5w058St
=+so8
-----END PGP SIGNATURE-----
