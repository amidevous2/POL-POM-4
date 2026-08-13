#!/bin/bash
# Date : (2016-05-02 16-33)
# Last revision : (2016-05-02 16-33)
# Wine version used : 1.8.2
# Distribution used to test : Arch Linux
# Author : ZeNity_
# Licence : GPLv3
 
[ "$PLAYONLINUX" == "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Sudeki"
PREFIX="Sudeki"
EDITOR="Climax Group"
EDITOR_URL="http://www.climaxstudios.com/menu"
AUTHOR="ZeNity_"
WINE_VERSION="1.8.2"
GAME_VMS="128"
STEAM_ID="233350"
 
# Open installation wizard window
POL_SetupWindow_Init
 
# Start debugging API
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
 
# Prepare Wine prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINE_VERSION"
 
# Choice of installation media
POL_SetupWindow_InstallMethod "DVD,STEAM"
 
# Install mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
fi
 
# Install the game
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Install from DVD
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup-1.bin"
	cd "$CDROM"
	POL_Wine "setup.exe"
	POL_Wine_WaitExit "$TITLE"
else
	# Install from Steam
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine "Steam.exe" "steam://install/$STEAM_ID"
	POL_Wine_WaitExit "$TITLE"
fi
 
# Ask for memory size of graphics card
POL_SetupWindow_VMS "$GAME_VMS"
 
# Create shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "Steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
else
	POL_Shortcut "Sudeki.exe" "$TITLE"
fi
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNW/QwAKCRDlMfrJqhPK
R7KiAJ9UiMkx8uoXflS9ZSCtVqYpJWUWxgCePXI0COjgoUBreAt3bxiIJe5rKtk=
=sRYE
-----END PGP SIGNATURE-----
