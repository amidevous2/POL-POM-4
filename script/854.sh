#!/bin/bash
# Date : (2011-07-07 21-00)
# Last revision : 
# Wine version used : 1.3.23
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-07-07 21-00)
#   Initial script.
# [GNU_Raziel] (2011-09-24 11:29)
#
# [Dadu042] (2020-01-29 21:00)
#   Wine 1.3.23 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dungeon Siege III" 
TITLE_DEMO="Dungeon Siege III (Demo)"
PREFIX="Dungeon_Siege_3"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/DungeonSiege3/top.jpg" "http://files.playonlinux.com/resources/setups/DungeonSiege3/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Obsidian" "http://www.dungeonsiege.com/language.php" "GNU_Raziel" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,DVD,STEAM,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dxfullsetup

# Mandatory pre-install fix for steam
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Call POL_Install_steam_flags "39230"
else
	POL_Call POL_Install_steam_flags "901638"
fi

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Dungeon Siege III_disk1.sim"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Do not forget to close Steam when downloading\nis finished, so that $APPLICATION_TITLE can continue\nto install your game.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/39230
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Do not forget to close Steam when downloading\nis finished, so that $APPLICATION_TITLE can continue\nto install your game.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/901638
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
POL_Wine_OverrideDLL "" "mmdevapi" # Only if wine < 1.3.25
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcuts
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Shortcut "steam.exe" "$TITLE_DEMO" "$TITLE.png" "steam://rungameid/39230"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/901638"
else
	POL_Shortcut "Dungeon Siege III.exe" "$TITLE" "$TITLE.png" ""
fi

# Game Warning
POL_SetupWindow_message "$(eval_gettext 'You must not set shadow level to its maximum\nor you will have to delete and redo installation of the game.')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjICNwAKCRDlMfrJqhPK
R5coAKCZ0pZkSZdocJPfPL4kGhIWt85tvACeOdL4Le7lSCB4U6pa/p3Q6BQvKt4=
=8oEq
-----END PGP SIGNATURE-----
