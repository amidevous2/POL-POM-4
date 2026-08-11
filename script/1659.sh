#!/bin/bash
# Date : (2013-04-15 21:00)
# Last revision : N/A
# Wine version used : 1.5.28
# Distribution used to test : Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2013-04-15 21:00)
#   Initial script.
# [Dadu042] (2020-01-29 21:00)
#   Wine 1.5.28 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="DmC: Devil May Cry"
SHORTCUT_NAME="DmC: Devil May Cry"
PREFIX="Devil_may_Cry"
EDITOR="Capcom"
GAME_URL="http://www.capcom.co.jp/dmc/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="1024"
STEAM_ID="220440"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/DmC/top.jpg" "http://files.playonlinux.com/resources/setups/DmC/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1659

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For DotNet and Mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dotnet40 # Mandatory for that game
POL_Call POL_Install_dxfullsetup # Fix some game crash

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Fix for this game
POL_Wine_X11Drv "GrabFullscreen" "Y"

# Increase performances - Nvidia driver only, crash games with ATI/AMD driver most of the time
POL_Wine_DetectCard
if [ "$DRVID" = "NVIDIA" ]; then
	POL_Wine_Direct3D "UseGLSL" "disabled"
fi

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Shortcut done before install for steam version
POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "steam://rungameid/$STEAM_ID" "Game;ActionGame;"
POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"

# Begin game installation
# Steam install
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished, do NOT click on Play.\n\nClose COMPLETELY he Steam interface, \nso that the installation script can continue')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjH/jAAKCRDlMfrJqhPK
R4diAKCkiOs2jB+hYCdxVA5AB78KzSWyJgCggBcg8m+8/cjo7H1sFGoWgZWU7FA=
=40PB
-----END PGP SIGNATURE-----
