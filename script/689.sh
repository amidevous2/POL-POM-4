#!/bin/bash
# Date : (2010-03-09 19-00)
# Last revision : see changelog
# Wine version used : 1.3.3, 1.3.8, 1.3.15-MousePbPatch, 1.3.23, 1.3.27, 1.5.3-ubisoft2
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2010-03-09)
#   First script.
# [Dadu042] (2019-12-12)
#   Wine "1.5.3-ubisoft2" -> 3.0.3
#1
## Begin Note ##
# Used patch to fix "ReadFileEx failture", see Bug #28119 - http://bugs.winehq.org/show_bug.cgi?id=28119
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Assassin's Creed 2"
PREFIX="AssassinsCreed2"
EDITOR="Ubisoft"
GAME_URL="http://assassinscreed.uk.ubi.com/assassins-creed-2/"
AUTOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/AC2/top.jpg" "http://files.playonlinux.com/resources/setups/AC2/left.jpg" "$TITLE"
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
	STEAM_ID="33230"
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

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "ac2.ico"
	POL_Wine start /unix "$CDROM/setup.exe"
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
	#Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "AssassinsCreedIIGame.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfKWyQAKCRDlMfrJqhPK
R+P5AJ9IQOQ38jGFZ6m8uAmvBcNvAIZ4mQCdEJHKlSmmfjhVe253XTBe4YelsLU=
=cpDA
-----END PGP SIGNATURE-----
