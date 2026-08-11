#!/bin/bash
# Date : (2018-08-21 22-46)
# Last revision : (2018-08-21 22-46)
# Wine version used : 3.0.2
# Distribution used to test : Ubuntu 18.04 x64 with I7-7700K and GTX 1070
# Script licence : GPL3
# Licence : retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Grand Theft Auto : Vice City"
PREFIX="GTAVC"
EDITOR="Rockstar Games"
AUTHOR="LinuxScripter"
GAME_URL="http://www.rockstargames.com/grandtheftauto/"
WORKINGWINEVERSION="3.0.2"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_SetupWindow_InstallMethod "CD,LOCAL"
if [ "$INSTALL_METHOD" = "CD" ]; then
POL_SetupWindow_cdrom
#POL_SetupWindow_check_cdrom "setup.ico"
POL_Wine start /unix "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"
else
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
fi
 
POL_Shortcut "gtavc.exe" "$TITLE" "" ""
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOlrIAAKCRDlMfrJqhPK
R26hAKCRF1TBy9yU8r0e8E6mSSiajKHKoQCfWOE/PPjtIiPuBiD4fxhbG2BwPfM=
=OMlb
-----END PGP SIGNATURE-----
