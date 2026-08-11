#!/bin/bash
# Date : (2018-02-06 11-10)
# Last revision : (2018-02-06 11-10)
# Wine version used : 3.0
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Cities: Skylines"
PREFIX="CitiesSkylines"
WORKING_WINE_VERSION="3.0"
AUTHOR="LinuxScripter"
EDITOR="Colossal Order"
GAME_URL="http://www.citiesskylines.com/"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_vcrun2010

POL_SetupWindow_message "$(eval_gettext 'Before launching the game add -force-glcore or -force-opengl\nto your launch options by right clicking the game under Properties, Launch Options. Otherwise the game might lag in bigger cities.')"

POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/255710
POL_Wine_WaitBefore "$TITLE"

POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/255710"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlp7c4MACgkQ5TH6yaoTykdbvwCggVP2OrIBYAHzZ1PDXHKF0sed
GrIAnj8Wnc4WzqfOLP2BqsqwDiP5n8j/
=lkoJ
-----END PGP SIGNATURE-----
