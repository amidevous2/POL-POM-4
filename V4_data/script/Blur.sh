#!/bin/bash
# Date : (2010-06-09 22-00)
# Last revision : (2019-11-03 19:41)
# Wine version used : 1.2, 1.3.15, 1.3.23, 1.3.27
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [GNU_Raziel] (2010-06-09 22-00)
#   First script.
# [Dadu042] (2019-11-03)
#   Wine 1.3.27 -> 3.0.3
#   Add POL_Function_NoCDWarning
#   Add POL_RequiredVersion

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Blur"
PREFIX="BlurTheGame"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/blur/top.jpg" "http://files.playonlinux.com/resources/setups/blur/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Activision" "http://www.blurgame.com/" "GNU_Raziel" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "42640"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/42640
	PPOL_Wine_WaitExit "$TITLE"
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

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/42640"
else
	POL_Shortcut "Blur.exe" "$TITLE" "$TITLE.png" ""
fi

# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
    POL_Call POL_Function_NoCDWarning
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXb7NOwAKCRDlMfrJqhPK
R26XAJ9h2u+5r/FfOXH6Iu38h26nO8Sc4QCeM/BsLEx7fefxClUcBCMZjWOUycU=
=64OM
-----END PGP SIGNATURE-----
