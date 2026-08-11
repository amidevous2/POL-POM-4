#!/bin/bash
# Date : (2011-09-07 21-00)
# Last revision : see changelog.
# Wine version used : 1.3.23, 1.3.25, 1.3.37, 1.5.9
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-09-07 21-00)
#   Initial script.
# [GNU_Raziel] (2012-07-21 21:00)
#   ?
# [Dadu042] (2020-01-27 23:30)
#   Wine 1.5.9 (outdated) -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Half-Life 2 : Episode One" 
PREFIX="hl2_ep1"
EDITOR="Valve"
GAME_URL="http://www.valvesoftware.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"
STEAM_ID="380"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/hl2ep1/top.jpg" "http://files.playonlinux.com/resources/setups/hl2ep1/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Valve" "http://www.valvesoftware.com/" "GNU_Raziel" "$PREFIX" 
 
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

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCF/wAKCRDlMfrJqhPK
R1GNAJ9IiBape8whI+3+Izt9h0d0+nwUjACbBCgeoinbcNty0AA4C3VBrwRdpv8=
=kCfi
-----END PGP SIGNATURE-----
