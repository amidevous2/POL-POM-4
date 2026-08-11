#!/bin/bash
# Date : (2014-07-16 19:00)
# Last revision : (2014-07-16 19:30)
# Wine version used : 1.7.15
# Distribution used to test : Ubuntu 14.04
# Author : Foz
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Foz] (2014-07-16)
#   First script.
# [Dadu042] (2019-12-18)
#   Wine 1.7.15 -> 2.22.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Talisman: Digital Edition"
PREFIX="TalismanDigital"
EDITOR="Nomad Games"
GAME_URL="http://www.talisman-game.com/"
AUTHOR="Foz"
STEAM_ID="247000"
WORKING_WINE_VERSION="2.22"
 
# Starting the script
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init

# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Determine Architecture
POL_System_SetArch "x86"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Installing mandatory dependencies
POL_Call POL_Install_steam

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Disable Steam In Game Overlay
POL_Wine_OverrideDLL "" "gameoverlayrenderer"
 
# Begin game installation
# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Shortcut done before install for steam version
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"

# Steam install
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXfklggAKCRDlMfrJqhPK
R8sbAKCEQoQs09V81GH3tfxBh7fWWFS0hwCfZ4LQc7QBnyadCa1P6r/zdiZkAws=
=RAih
-----END PGP SIGNATURE-----
