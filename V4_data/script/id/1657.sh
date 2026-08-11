#!/bin/bash
# Date : (2013-04-14 21:00)
# Last revision : N/A
# Wine version used : 1.5.19
# Distribution used to test : Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
# wine-staging has a fix for bug #33479 Multiple games (Guild Wars 2, Risen 2, Tomb Raider 2013): Raw input is broken

# CHANGELOG
# [GNU_Raziel] (2013-04-14 21:00)
#   First script.
# [Dadu042] (2020-03-28)
#   Wine "1.7.46-staging" (outdated) -> 3.0.3 . Not tested.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Tomb Raider (2013)"
SHORTCUT_NAME="Tomb Raider (2013)"
SHORTCUT_NAME2="Tomb Raider 2013"
PREFIX="Tomb_Raider_2013"
EDITOR="Square Enix"
GAME_URL="http://tombraider.com"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="1024"
STEAM_ID="203160"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/TR2k13/top.jpg" "http://files.playonlinux.com/resources/setups/TR2k13/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1657

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup # Fix some game crash

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Fix for this game
POL_Wine_X11Drv "GrabFullscreen" "Y"

# Increase performances - Nvidia Driver Only, crash games with ATI/AMD driver most of the time
POL_Wine_DetectCard
if [ "$DRVID" = "NVIDIA" ]; then
	POL_Wine_Direct3D "UseGLSL" "disabled"
fi

# Fix Flickering screen
POL_Wine_Direct3D "StrictDrawOrdering" "enabled"

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Shortcut done before install for steam version
POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "steam://rungameid/$STEAM_ID" "Game;AdventureGame;"
POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME2)" "" "" "Game;"

# Fix mouse control when using StrickDrawOrdering - Thx to petch
## Begin Fix ##
cd "$POL_USER_ROOT/tmp"
POL_Download "http://files.playonlinux.com/nircmd.zip" "3d6d3f094633c5c97f8b15f8fe1023bf"
POL_System_ExtractSingleFile "nircmd.zip" "nircmd.exe" "$WINEPREFIX/drive_c/windows/nircmd.exe"

POL_Wine_reboot

# Double quotes around "P"OL_Wine prevent POL getArgs to pickup this line, sorry for the hack
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '(sleep 10; "P"OL_Wine nircmd.exe win hide title "$SHORTCUT_NAME"; sleep 0.1; "P"OL_Wine nircmd.exe win hideshow title "$SHORTCUT_NAME")&'
echo "wait" >> "$POL_USER_ROOT/shortcuts/$SHORTCUT_NAME"
## End Fix ##

# Begin game installation
# Steam install
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished, do NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/R4AAKCRDlMfrJqhPK
RyTMAJ9sXi3SCajvFsIFde8xxcLbJhJlFACePglNnoLzt2YRaUxaI78r/7R4g7w=
=HAmG
-----END PGP SIGNATURE-----
