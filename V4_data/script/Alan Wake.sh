#!/bin/bash
# Date : (2012-02-22 21:00)
# Last revision : see changelog
# Wine version used : 1.4-rc4-raw3, 1.5.0-raw3
# Distribution used to test : Linux Mint 12 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2012-02-22 21:00)
#   Initial script.
# [GNU_Raziel] (2015-07-05)
#   ?
# [Dadu042] (2020-02-01 23:40)
#   Wine "1.7.46-staging" -> 2.22


## Begin Note ##
# Used RawInput3 patch to fix Bug #20395 - http://bugs.winehq.org/show_bug.cgi?id=20395
# bug id #20395 marked fixed in 1.5.13.
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Alan Wake"
PREFIX="Alan_Wake"
EDITOR="Remedy"
GAME_URL="http://www.alanwake.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="512"

# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/alan_wake/top.jpg" "http://files.playonlinux.com/resources/setups/alan_wake/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM"

# Installing mandatory dependencies
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup

# Mandatory pre-install fix for steam
STEAM_ID="108710"
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##

# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjYEqAAKCRDlMfrJqhPK
R0bUAKCM0yIMBkyP6Sk6pieLaarRMYzIiwCgqlooGJwQXZuZFC8qvy5P2dkHInA=
=yvOY
-----END PGP SIGNATURE-----
