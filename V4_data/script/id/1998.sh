#!/bin/bash
# Date : (2014-04-10T15:26Z)
# Last revision : (2015-03-16T04:47Z)
# Wine version used : 1.7.24-CS-0.9.1-DXHR
# Distribution used to test : Arch Linux x64
# Author : Alexander Borysov
# Script licence : GPLv3
# Program licence: Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Deus Ex: Human Revolution"
PREFIX="DXHR"
STEAM_APP_ID=28050

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1998
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Square Enix" "http://deusex.com/" "Alexander Borysov" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

POL_Wine_PrefixCreate "1.7.24-CS-0.9.1-DXHR"

POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# marginally higher fps
Set_OS "win7"

if [ "$INSTALL_METHOD" = "DVD" ]; then
   POL_SetupWindow_cdrom
   POL_SetupWindow_check_cdrom "DEHR.ico"
   POL_Wine "$CDROM/Setup.exe"
   POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Call POL_Install_steam
   cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
   POL_Wine "steam.exe" "steam://install/$STEAM_APP_ID"
   POL_Wine_WaitExit "$TITLE"
else
   POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
   POL_Wine "$APP_ANSWER"
   POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_VMS "512"

# On Nvidia, disabling GLSL removes the stutter you otherwise get. On AMD, it makes the game crash on start.
POL_Wine_DetectCard
[ "$DRVID" = "NVIDIA" ] && POL_Wine_Direct3D "UseGLSL" "disabled"
POL_Wine_Direct3D "CSMT" "enabled"


if [ "$INSTALL_METHOD" = "STEAM" ]; then
   POL_Shortcut "steam.exe" "$TITLE" "${TITLE}.png" "steam://rungameid/$STEAM_APP_ID -no-dwrite"
else
   POL_Shortcut "dxhr.exe" "$TITLE" "${TITLE}.png"
fi

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlbGU70ACgkQ5TH6yaoTykegEwCgg/XFN9o0QTHoyFJtowZrUkYM
MtMAoKmkU0cTqBZ5Nsq2cBi/2Y08AxO/
=iqF8
-----END PGP SIGNATURE-----
