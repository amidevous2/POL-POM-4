#!/bin/bash
# Date : (2014-11-18 12:12)
# Last revision : (2014-11-18 12:12)
# Wine version used : 1.7.5
# Distribution used to test : Fedora 20 - 64 bits
# Author : Tutul
# License : GNU/GPL v3
    
## Beta script ##
    
[ "$PLAYONLINUX" = "" ] && exit 1
source "$PLAYONLINUX/lib/sources"
    
TITLE="HAWKEN"
PREFIX="HAWKEN"
EDITOR="Adhesive Games"
GAME_URL="http://www.playhawken.com/"
AUTHOR="Tutul"
GAME_VMS="256"
STEAM_ID="271290"
    
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2346
    
# Starting debugging API
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
# Setting Wine Version
WORKING_WINE_VERSION="1.7.5"
    
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
    
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
    
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
    
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Install mandatory dependencies
POL_Call POL_Install_xact
POL_Call POL_Install_xinput
POL_Call POL_Install_d3dx9

# Prepare Steam
POL_Call POL_Install_steam
POL_Call POL_Install_steam_flags "$STEAM_ID"
    
# Run the install
POL_Wine_WaitBefore "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"
    
# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID" "Game;"

#Closing POL
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRsFzwACgkQ5TH6yaoTykfeoACfYROgTdPQgtbJkLQJg0j72GBH
qtcAoIY2NcmcM56K5L3xueP5akABj1/N
=B9/i
-----END PGP SIGNATURE-----
