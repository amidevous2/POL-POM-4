#!/bin/bash
# Date : (2009-05-06 13-00)
# Last revision : see changelog
# Wine version used : 1.1.37, 1.3.15, 1.3.26, 1.7.53-steam_crossoverhack
# Distribution used to test : Fedora 12
# Author : NSLW & Tinou
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [NSLW & Tinou] (2009-05-06 13-00)
#
# [?] (2015-11-12 15:07)
#   Initial script.
# [Dadu042] (2020-01-27 23:00)
#   Wine Linux 1.7.53-steam_crossoverhack (addresses Wine HQ bug 39403) -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Fallout 3"
TITLE_CONFIG="Fallout 3 - Configurator"
PREFIX="Fallout3"
WORKING_WINE_VERSION="3.0.3"
[ "$POL_OS" = "Mac" ] && WORKING_WINE_VERSION="1.3.16-xliveless2" # Fix mouse problem
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/fallout3/left.jpeg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 402

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bethesda Softworks" "http://fallout.bethsoft.com" "NSWL & Tinou" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # Needed for DVD setup
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

#Installing mandatory components
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    Set_OS "winxp" # fix to prevent steamwebhelper.exe crash after update
	POL_Call POL_Install_steam
fi

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	Set_OS "win7" # fix for DVD
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_SetupWindow_menu "$(eval_gettext 'Which version do you have?')" "$TITLE" "$(eval_gettext 'Normal version')~$(eval_gettext 'Game Of The Year version')" "~"
	if [ "$APP_ANSWER" == "$(eval_gettext 'Normal version')" ]; then
		# Mandatory pre-install fix for steam
		POL_Call POL_Install_steam_flags "22300"
		POL_Wine start /unix "Steam.exe" -applaunch 22300
	else
		# Mandatory pre-install fix for steam
		POL_Call POL_Install_steam_flags "22370"
		POL_Wine start /unix "Steam.exe" -applaunch 22370
	fi
	POL_SetupWindow_message "$(eval_gettext 'Click on "Forward" ONLY when Steam game installation\nwill be finished or you will have to redo the installation.')" "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installation in progress...')" "$TITLE"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit
fi

# Remove GFLW
POL_Call POL_Remove_gfwl

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
POL_Shortcut "Fallout3.exe" "$TITLE" "" "" "Game;"
POL_Shortcut "FalloutLauncher.exe" "$TITLE_CONFIG" "" ""

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Game protection warning
	POL_Call POL_Function_NoCDWarning
fi
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjIHNAAKCRDlMfrJqhPK
R7cSAJ4tvWkqM+PT6qBCJSasByUY4X8bTACfdnZAVXrr36gf4f1FfgQA6TbQWWU=
=Pp8m
-----END PGP SIGNATURE-----
