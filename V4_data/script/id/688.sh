#!/bin/bash
# Date : (2010-01-09 22-00)
# Last revision : See changelog
# Wine version used : 1.2, 1.2.1, 1.2.3, 1.5.28
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# GNU_Raziel (2010 to 2011-08-19)
#   Initial writting.
# [Dadu042] (2019-06-20)
#   Wine 1.5.28 -> 1.9.24. Little changes (NOCD).
# [Dadu042] (2020-02-03)
#   Wine 1.9.24 (outdated) -> 3.0.3.

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Devil May Cry 4"
PREFIX="dmc4"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/dmc4/top.jpg" "http://files.playonlinux.com/resources/setups/dmc4/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Capcom" "http://www.capcom.co.jp/devil4/" "GNU_Raziel" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_Call POL_Function_NoCDWarning
fi

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
fi

POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_wmp9
POL_Call POL_Install_wmpcodecs 

 
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "DevilMayCry4.ico"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "45700"
        
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/45700
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
## Fix for this game
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/45700"
else
        POL_Shortcut "DevilMayCry4_DX9.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiRygAKCRDlMfrJqhPK
R5+WAJ4iKwugzk33SsvD/osQSUl6jD8M7gCgjDoawJbZficlclDi7r5Ym+3Hyfw=
=0Pnt
-----END PGP SIGNATURE-----
