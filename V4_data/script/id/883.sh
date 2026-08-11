#!/bin/bash
# Date : (2011-17-07 21-00)
# Last revision : see changelog
# Wine version used : 1.3.23, 1.3.28, 1.4, 1.5.31, 2.22
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG:
# [GNU_Raziel] (2011-17-07 21-00)
#   First script.
# [GNU_Raziel] (2013-06-21 21:00)
#   ?
# [Dadu042] (2019-12-23)
#   Wine 1.5.31 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Witcher 2 : Assassins of Kings"
SHORTCUT_NAME="The Witcher 2 : Assassins of Kings"
SHORTCUT_NAME2="The Witcher 2 : Assassins of Kings (Configuration)" 
PREFIX="witcher2"
EDITOR="CDProjekt"
GAME_URL="http://www.thewitcher.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="512"
STEAM_ID="20920"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/witcher2/top.jpg" "http://files.playonlinux.com/resources/setups/witcher2/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 883

# Starting debugging API
POL_Debug_Init

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
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "steam://rungameid/$STEAM_ID" "Game;RolePlaying;"
	POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"
fi
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_dotnet40

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix graphic corruption for this game - May crash with ATI/AMD and Intel GPUs
POL_Wine_Direct3D "UseGLSL" "disabled"

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "witcher2.ico"
	# Disk 1
	cd "$WINEPREFIX"/dosdevices
	ln -sf "$CDROM" p:
	POL_Wine start /unix "$CDROM"/setup.exe
	# Ejecting Disk 1
	POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk\nclick on "Forward"')" "$TITLE"
	POL_Wine eject
	# Disk 2
	POL_SetupWindow_message "$(eval_gettext 'Please insert nest media into your disk drive')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "data3.cab"
	cd "$WINEPREFIX/dosdevices"
	rm ./p:
	ln -sf "$CDROM" p:
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

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "witcher2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
fi
POL_Shortcut "Configurator.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgHgdQAKCRDlMfrJqhPK
R6EkAKCGYmqATVmkXsgVa1rOfOSFzl14CwCgseVkVUqDQGHSGGyvmEsQzSKT16s=
=oyzy
-----END PGP SIGNATURE-----
