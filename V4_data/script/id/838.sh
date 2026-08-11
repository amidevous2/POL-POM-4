#!/bin/bash
# Date : (2011-20-04 21:00)
# Last revision : (2013-06-25 21:00)
# Wine version used : 1.3.18, 1.3.23, 1.3.25, 1.3.28, 1.3.37, 1.5.9, 1.5.31
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

## Note ##
# Corriger le scintillement de l'image : il suffit de désactiver la "synchronisation verticale" dans les options graphiques du jeu.
# Fix blinking screen : All you have to do is disable "vertical sync" in the game's graphic options.
##########

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Portal 2"
PREFIX="portal2"
EDITOR="Valve"
GAME_URL="http://www.valvesoftware.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="1.7.34"
GAME_VMS="512"
STEAM_ID="620"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/portal2/top.jpg" "http://files.playonlinux.com/resources/setups/portal2/left.jpg" "$TITLE"
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
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_steam
#POL_Call POL_Install_vcrun2008
#POL_Call POL_Install_vcrun2010

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Shortcut done before install for steam version
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "portal2.ico"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
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
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlTyDvgACgkQ5TH6yaoTykeaOQCeLClT0tHxuLkGDDxCKS+86/gz
/CAAn0/FUu8AXgaOFRN6bvf+Re/Gdzrv
=hswX
-----END PGP SIGNATURE-----
