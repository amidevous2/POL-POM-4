#!/bin/bash
# Date : (2011-09-07 21:00)
# Last revision : (2013-06-25 21:00)
# Wine version used : 1.3.23, 1.3.25, 1.3.37, 1.5.9, 1.5.31
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG:
# [GNU_Raziel] (2011-09-07 21:00)
#   First script.
# [GNU_Raziel ?] (2013-06-25 21:00)
#   ?
# [Dadu042] (2019-12-24)
#   Wine 1.5.31 -> 2.22
#   Fix POL_Shortcut missing for DVD.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Portal" 
PREFIX="portal"
EDITOR="Valve"
GAME_URL="http://www.valvesoftware.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"
STEAM_ID="400"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/portal/top.jpg" "http://files.playonlinux.com/resources/setups/portal/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_SetupWindow_checkexist()
{	
	if [ -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		STEAM=`find $WINEPREFIX -name "Steam.exe"`
		if [ "$STEAM" != "" ]; then
			POL_SetupWindow_menu "$(eval_gettext 'Steam installation has been detected\nwould you like to install this game in the same virtual drive?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
			STEAM_USE=$APP_ANSWER
			if [ "$STEAM_USE" == "$(eval_gettext 'Yes')" ]; then
				STEAM_USE="1"
				PREFIX="Steam"
			else
				STEAM_USE="0"
			fi
		fi
	else
		STEAM_USE="0"
	fi
}
 
POL_SetupWindow_checkexist "Steam"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

if [ "$STEAM_USE" == "0" ]; then
	# Downloading wine if necessary and creating prefix
	POL_System_SetArch "x86"
	POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
fi

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM"

# Installing mandatory dependencies
if [ "$STEAM_USE" == "0" ]; then
	POL_Call POL_Install_steam
fi

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Shortcut done before install for steam version
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Setup.exe"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
	POL_Shortcut "portal.exe" "$TITLE" "" "" "Game;"
else
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgItuQAKCRDlMfrJqhPK
RzVgAJ4kxIWYlS7r9kdtuxKge68zbDIYeACggnVFb1eK9lQ8K950eLZ/iWSBTHw=
=P4MP
-----END PGP SIGNATURE-----
