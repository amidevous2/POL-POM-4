#!/bin/bash
# Date : (2010-18-09 14-00)
# Last revision : (2012-05-04 21:00)
# Wine version used : 1.3.2, 1.4
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Worms Reloaded"
TITLE_DEMO="Worms Reloaded (Demo)"
PREFIX="WormsReloaded"
EDITOR="Team 17"
GAME_URL="http://www.team17.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.4"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wormsreloaded/top.jpg" "http://files.playonlinux.com/resources/setups/wormsreloaded/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between Steam and other Digital Download version
POL_SetupWindow_InstallMethod "STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	POL_Call POL_Install_steam
fi
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_dxfullsetup

# Mandatory settings for steam
[ "$INSTALL_METHOD" == "STEAM_DEMO" ] && { STEAM_ID="22690"; SHORTCUT_NAME="$TITLE_DEMO"; }
[ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="22600"; SHORTCUT_NAME="$TITLE"; }

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Begin installation
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
	POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"

	# Shortcut done after install for local version
	POL_Shortcut "WormsReloaded.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+jxkIACgkQ5TH6yaoTykch7ACfRS+gKvwu7o2YbC+5ebG0OR67
I58An1JMUqu/jtkVV1fim7wu+Kr5A8W2
=G7NW
-----END PGP SIGNATURE-----
