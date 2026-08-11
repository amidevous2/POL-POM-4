#!/bin/bash
# Date : (2011-21-03 21-00)
# Last revision : (2012-05-10 21:00)
# Wine version used : 1.3.15-MousePbPatch, 1.3.23, 1.3.26, 1.3.27, 1.5.3-ubisoft2
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

## Begin Note ##
# Used patch to fix "ReadFileEx failture", see Bug #28119 - http://bugs.winehq.org/show_bug.cgi?id=28119
# this patch is no longer needed 
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Assassin's Creed Brotherhood"
PREFIX="AssassinsCreedBrotherhood"
EDITOR="Ubisoft"
GAME_URL="http://assassinscreed.uk.ubi.com/"
AUTOR="GNU_Raziel"
WORKING_WINE_VERSION="1.7.46-staging"
GAME_VMS="512"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ACB/top.jpg" "http://files.playonlinux.com/resources/setups/ACB/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	STEAM_ID="48190"
fi
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx
POL_Call POL_Install_ubigamelauncher

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# "Missing folder" crash fix
WINE_USER=`id -un`
mkdir -p "$WINEPREFIX/drive_c/users/$WINE_USER/Saved Games/"

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "autorun.ico"
	POL_Wine start /unix "$CDROM/setup.exe"
	# Killing unwanted sub-process perturbating install
	sleep 10
	killall -9 "install.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
	POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "AssassinsCreedBrotherhood.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlWfsjMACgkQ5TH6yaoTykdNiACeNB7K0dw5c52HRYnxo5gPXMK1
Jy4An2tpikWJ7XOHZiJc6nouxZ+0FG5B
=gbkk
-----END PGP SIGNATURE-----
