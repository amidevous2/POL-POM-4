#!/bin/bash
# Date : (2012-02-21 21:00)
# Last revision : (2014-02-12 12:00)
# Wine version used : 1.7.10
# Distribution used to test : Linux Mint 12 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2012-02-21 21:00)
#   Initial script.
# [Dadu042] (2020-01-27 23:30)
#   Wine 1.7.10 -> 2.22
#   Improve POL_Shortcut

## Begin Note ##
# Used RawInput3 patch to fix Bug #20395 - http://bugs.winehq.org/show_bug.cgi?id=20395
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Kingdoms of Amalur : Reckoning"
TITLE_DEMO="Kingdoms of Amalur : Reckoning (Demo)"
PREFIX="KoA_Reckoning"
EDITOR="Big Huge Games"
GAME_URL="http://www.ea.com/uk/reckoning"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="512"

if [ "$POL_LANG" == "fr" ]; then
TITLE="Les Royaumes d'Amalur : Reckoning"
TITLE_DEMO="Les Royaumes d'Amalur : Reckoning (Demo)"
GAME_URL="http://www.ea.com/fr/reckoning"
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/KoA_Reckoning/top.jpg" "http://files.playonlinux.com/resources/setups/KoA_Reckoning/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "STEAM_DEMO,DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_wininet # Fix EA Connexion's issue 1

# Mandatory pre-install fix for steam
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Call POL_Install_steam_flags "203970"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam_flags "102500"
fi

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/203970
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/102500
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
# Fix EA connexion's issue 2
mkdir -p "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/system32/drivers/etc/"
touch "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/system32/drivers/etc/hosts"

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Shortcut "steam.exe" "$TITLE_DEMO" "KoA_Reckoning.png" "steam://rungameid/203970"
elif [ "$INSTALL_METHOD" == "DVD" ] || [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "KoA_Reckoning.png" "steam://rungameid/102500"
else
	POL_Shortcut "Reckoning.exe" "$TITLE" "" "" "Game;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCKYQAKCRDlMfrJqhPK
R2brAKCxfUjYfE5rtE4wXkcP5DrNOG8vUACgg28VR2RZxREuYXR0LgUhCXmSe+c=
=mBeh
-----END PGP SIGNATURE-----
