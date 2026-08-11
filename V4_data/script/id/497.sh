#!/bin/bash
# Date : (2009-10-18 10-00)
# Last revision : (2009-10-19 18-10)
# Wine version used : 1.1.31
# Distribution used to test : Ubuntu 9.04
# Author : zedtux
# Licence : Retail

GAMENAME="FlatOut 2"
PREFIX="flatout2"
NEEDEDWINEVERSION="1.1.31"
MENU_ACTION_INSTALL="Install the game"
MENU_ACTION_PATCH="Patch the game"
GAME_SETUP="setup.exe"
PATCHMIME="application/zip"
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

# Verify playonlinux dependencies
[ "$PLAYONLINUX" = "" ] && exit 0 
source "$PLAYONLINUX/lib/sources"

# Get Cover and convert it
wget http://upload.wikimedia.org/wikipedia/en/4/40/Flatout2pc.jpg --output-document="$REPERTOIRE/tmp/flatout2.cover.jpeg"
convert "$REPERTOIRE/tmp/flatout2.cover.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.flatout.2.jpeg"

# Initialize the main window
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.flatout.2.jpeg"
POL_SetupWindow_presentation "$GAMENAME" "zedtux" "http://www.zedroot.org" "zedtux" "$PREFIX"


select_prefix "$REPERTOIRE/wineprefix/$PREFIX"


# Provide possibility to run install of a patch for the game
patch_game()
{
	POL_SetupWindow_browse "Select the patch file for $GAMENAME (Should be like flatout_2_patch_*.zip)" "Patching $GAMENAME" ""
	if [ "$APP_ANSWER" != "" ] ; then
		if [ `file -bi "$APP_ANSWER"` == "$PATCHMIME" ] ; then
			
			# Extract file, and replace existing files in the game folder
			cd "$REPERTOIRE/wineprefix/$PREFIX/drive_c/$PROGRAMFILES/Empire Interactive/FlatOut2"
			echo "Unziping patch into `pwd`"
			unzip -o "$APP_ANSWER"
		fi
		POL_SetupWindow_message "$GAMENAME patched successfully" "$TYTUL"
		POL_SetupWindow_Close
		exit
	fi
}

# Create Wine environnement before install the game
POL_SetupWindow_prefixcreate


#
# Make a menu to select one action
#

# Give the choice to user between install or patch the game
POL_SetupWindow_menu "What do you want to do?" "Actions" "$MENU_ACTION_INSTALL~$MENU_ACTION_PATCH" "~"

if [ "$APP_ANSWER" == "$MENU_ACTION_PATCH" ]; then
	patch_game
	POL_SetupWindow_Close
fi

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "$GAME_SETUP"

# Adding CD-ROM as drive d: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" d:
cd "$WINEPREFIX/drive_c/windows/temp/" 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg

# Launching Installation
POL_SetupWindow_wait_next_signal "Installing $GAMENAME..." "$GAMENAME"
cd "$CDROM"
wine "$GAME_SETUP"

# Defining options of the environnement
POL_SetupWindow_install_wine "$NEEDEDWINEVERSION"
Set_WineVersion_Assign "$NEEDEDWINEVERSION" "$GAMENAME"

# Creating shortcut
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Empire Interactive/FlatOut2" "FlatOut2.exe" "" "$GAMENAME" ""

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Empire Interactive/FlatOut2" "FlatOut2.exe" "" "$GAMENAME Setup" "" "-setup"

POL_SetupWindow_message "$GAMENAME has been installed successfully" "$GAMENAME"

# Close the main window !
POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFUACgkQ5TH6yaoTykeCbACfa3YoQHSlohT5aHCS/Egc38ZX
rEcAnivjbVrkzoOnVNGwHx9UjZlqMFbz
=zAf6
-----END PGP SIGNATURE-----
